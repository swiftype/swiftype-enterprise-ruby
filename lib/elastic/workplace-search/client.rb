require 'set'
require 'elastic/workplace-search/configuration'
require 'elastic/workplace-search/request'
require 'elastic/workplace-search/utils'

module Elastic
  module WorkplaceSearch
    # API client for the {Elastic Workplace Search API}[https://www.elastic.co/workplace-search].
    class Client
      autoload :ContentSourceDocuments, 'elastic/workplace-search/client/content_source_documents.rb'
      autoload :Permissions, 'elastic/workplace-search/client/permissions.rb'

      DEFAULT_TIMEOUT = 15

      include Elastic::WorkplaceSearch::Request

      def self.configure(&block)
        Elastic::WorkplaceSearch.configure &block
      end

      # Create a new Elastic::WorkplaceSearch::Client client
      #
      # @param options [Hash] a hash of configuration options that will override what is set on the Elastic::WorkplaceSearch class.
      # @option options [String] :access_token an Access Token to use for this client
      # @option options [Numeric] :overall_timeout overall timeout for requests in seconds (default: 15s)
      # @option options [Numeric] :open_timeout the number of seconds Net::HTTP (default: 15s)
      #   will wait while opening a connection before raising a Timeout::Error
      # @option options [String] :proxy url of proxy to use, ex: "http://localhost:8888"
      def initialize(options = {})
        @options = options
      end

      def access_token
        @options[:access_token] || Elastic::WorkplaceSearch.access_token
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

      include Elastic::WorkplaceSearch::Client::ContentSourceDocuments
      include Elastic::WorkplaceSearch::Client::Permissions
    end
  end
end
