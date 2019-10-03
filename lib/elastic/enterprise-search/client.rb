require 'set'
require 'elastic/enterprise-search/configuration'
require 'elastic/enterprise-search/request'
require 'elastic/enterprise-search/utils'

module Elastic
  module EnterpriseSearch
    # API client for the {Elastic Enterprise Search API}[https://swiftype.com/enterprise-search].
    class Client
      autoload :ContentSourceDocuments, 'elastic/enterprise-search/client/content_source_documents.rb'

      DEFAULT_TIMEOUT = 15

      include Elastic::EnterpriseSearch::Request

      def self.configure(&block)
        Elastic::EnterpriseSearch.configure &block
      end

      # Create a new Elastic::EnterpriseSearch::Client client
      #
      # @param options [Hash] a hash of configuration options that will override what is set on the Elastic::EnterpriseSearch class.
      # @option options [String] :access_token an Access Token to use for this client
      # @option options [Numeric] :overall_timeout overall timeout for requests in seconds (default: 15s)
      # @option options [Numeric] :open_timeout the number of seconds Net::HTTP (default: 15s)
      #   will wait while opening a connection before raising a Timeout::Error
      # @option options [String] :proxy url of proxy to use, ex: "http://localhost:8888"
      def initialize(options = {})
        @options = options
      end

      def access_token
        @options[:access_token] || Elastic::EnterpriseSearch.access_token
      end

      def open_timeout
        @options[:open_timeout] || DEFAULT_TIMEOUT
      end

      def proxy
        @options[:proxy]
      end

      def overall_timeout
        (@options[:overall_timeout] || DEFAULT_TIMEOUT).to_f
      end

      include Elastic::EnterpriseSearch::Client::ContentSourceDocuments
    end
  end
end
