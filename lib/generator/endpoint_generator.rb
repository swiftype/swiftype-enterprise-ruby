# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
module Elastic
  module Generator
    # Generates code for REST API Endpoints
    class EndpointGenerator
      def initialize(spec)
        @spec = spec
        @target_dir = "#{Generator::CURRENT_PATH}/api/".freeze
      end

      def generate
        Utils.empty_directory(@target_dir)

        # for each endpoint in the spec generate the code
        @spec['paths'].each do |endpoints|
          generate_classes(endpoints)
        end
      end

      private

      def generate_classes(endpoints)
        @path = replace_path_variables(endpoints[0])

        endpoints[1].each do |method, endpoint|
          @http_method = method
          setup_values!(endpoint)
          file_name = "#{@target_dir}#{@method_name}.rb"
          Utils.write_file(file_name, generate_method_code)
        end
      end

      def replace_path_variables(path)
        path.gsub(/{([a-z_]+)}/, '#{params[:\1]}')
      end

      def setup_values!(endpoint)
        @module_name = Utils.module_name(endpoint['tags'])
        @method_name = Utils.to_snakecase(endpoint['operationId'])
        @required_params = []
        setup_parameters!(endpoint['parameters'])
        @doc = setup_documentation(endpoint)
      end

      def setup_parameters!(params)
        @params = params.map { |param| parameter_name_and_description(param) }
      end

      def parameter_name_and_description(param)
        param['name'] = 'current_page' if param['name'] == 'page[current]'
        param['name'] = 'page_size' if param['name'] == 'page[size]'

        param_info = @spec.dig('components', 'parameters', param['name'])

        {
          'name' => param['name'],
          'description' => param_info['description'],
          'type' => param_info['schema']['type'],
          'required' => param_info['required']
        }
      end

      def required_params
        @params.select { |p| p['required'] }
      end

      def generate_method_code
        template = "#{Generator::CURRENT_PATH}/templates/endpoint_template.erb"
        code = ERB.new(File.read(template), nil, '-')
        code.result(binding)
      end

      def setup_documentation(endpoint)
        # Description is markdown with [description](external_url)
        # So we split the string with regexp:
        matches = endpoint['description'].match(/\[(.+)\]\((.+)\)/)
        description = matches[1]
        url = matches[2]
        <<~DOC
          # #{@module_name} - #{endpoint['summary']}
          # #{description}
          #
          #{parameters_doc}
          #
          # @see #{url}
          #
        DOC
      end

      def parameters_doc
        @params.map do |param|
          "# @option #{param['name']} - #{param['description']}" + ' (*Required*)' if param['required']
        end.join("\n")
      end
    end
  end
end