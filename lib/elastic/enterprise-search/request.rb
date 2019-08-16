require 'net/https'
require 'json'
require 'elastic/enterprise-search/exceptions'
require 'openssl'

module Elastic
  module EnterpriseSearch
    module Request
      def get(path, params={})
        request(:get, path, params)
      end

      def post(path, params={})
        request(:post, path, params)
      end

      def put(path, params={})
        request(:put, path, params)
      end

      def delete(path, params={})
        request(:delete, path, params)
      end

      # Construct and send a request to the API.
      #
      # @raise [Timeout::Error] when the timeout expires
      def request(method, path, params = {})
        Timeout.timeout(overall_timeout) do
          uri = URI.parse("#{Elastic::EnterpriseSearch.endpoint}#{path}")

          request = build_request(method, uri, params)
          http = Net::HTTP.new(uri.host, uri.port)
          http.open_timeout = open_timeout
          http.read_timeout = overall_timeout

          if uri.scheme == 'https'
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_PEER
            http.ca_file = File.join(File.dirname(__FILE__), '..', 'data', 'ca-bundle.crt')
            http.ssl_timeout = open_timeout
          end

          response = http.request(request)
          handle_errors(response)
          JSON.parse(response.body) if response.body && response.body.strip != ''
        end
      end

      private
      def handle_errors(response)
        case response
        when Net::HTTPSuccess
          response
        when Net::HTTPUnauthorized
          raise Elastic::EnterpriseSearch::InvalidCredentials
        when Net::HTTPNotFound
          raise Elastic::EnterpriseSearch::NonExistentRecord
        when Net::HTTPBadRequest
          raise Elastic::EnterpriseSearch::BadRequest
        when Net::HTTPForbidden
          raise Elastic::EnterpriseSearch::Forbidden
        else
          raise Elastic::EnterpriseSearch::UnexpectedHTTPException, "#{response.code} #{response.body}"
        end
      end

      def build_request(method, uri, params)
        klass = case method
                when :get
                  Net::HTTP::Get
                when :post
                  Net::HTTP::Post
                when :put
                  Net::HTTP::Put
                when :delete
                  Net::HTTP::Delete
                end

        case method
        when :get, :delete
          uri.query = URI.encode_www_form(params) if params && !params.empty?
          req = klass.new(uri.request_uri)
        when :post, :put
          req = klass.new(uri.request_uri)
          req.body = JSON.generate(params) unless params.length == 0
        end

        req['User-Agent'] = Elastic::EnterpriseSearch.user_agent
        req['Content-Type'] = 'application/json'
        req['Authorization'] = "Bearer #{access_token}"

        req
      end
    end
  end
end
