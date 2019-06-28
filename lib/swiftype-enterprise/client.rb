require 'set'
require 'swiftype-enterprise/configuration'
require 'swiftype-enterprise/request'
require 'swiftype-enterprise/utils'

module SwiftypeEnterprise
  # API client for the {Swiftype Enterprise API}[https://swiftype.com/enterprise-search].
  class Client
    DEFAULT_TIMEOUT = 15

    include SwiftypeEnterprise::Request

    def self.configure(&block)
      SwiftypeEnterprise.configure &block
    end

    # Create a new SwiftypeEnterprise::Client client
    #
    # @param options [Hash] a hash of configuration options that will override what is set on the SwiftypeEnterprise class.
    # @option options [String] :access_token an Access Token to use for this client
    # @option options [Numeric] :overall_timeout overall timeout for requests in seconds (default: 15s)
    # @option options [Numeric] :open_timeout the number of seconds Net::HTTP (default: 15s)
    #   will wait while opening a connection before raising a Timeout::Error
    def initialize(options = {})
      @options = options
    end

    def access_token
      @options[:access_token] || SwiftypeEnterprise.access_token
    end

    def open_timeout
      @options[:open_timeout] || DEFAULT_TIMEOUT
    end

    def overall_timeout
      (@options[:overall_timeout] || DEFAULT_TIMEOUT).to_f
    end

    # Documents have fields that can be searched or filtered.
    #
    # For more information on indexing documents, see the {Content Source documentation}[https://app.swiftype.com/ent/docs/custom_sources].
    module ContentSourceDocuments

      # Index a batch of documents using the {Content Source API}[https://app.swiftype.com/ent/docs/custom_sources].
      #
      # @param [String] content_source_key the unique Content Source key as found in your Content Sources dashboard
      # @param [Array] documents an Array of Document Hashes
      #
      # @return [Array<Hash>] an Array of Document indexing Results
      #
      # @raise [SwiftypeEnterprise::InvalidDocument] when a single document is missing required fields or contains unsupported fields
      # @raise [Timeout::Error] when timeout expires waiting for results
      def index_documents(content_source_key, documents)
        documents = Array(documents).map! { |document| normalize_document(document) }

        async_create_or_update_documents(content_source_key, documents)
      end

      # Destroy a batch of documents given a list of external IDs
      #
      # @param [Array<String>] document_ids an Array of Document External IDs
      #
      # @return [Array<Hash>] an Array of Document destroy result hashes
      #
      # @raise [Timeout::Error] when timeout expires waiting for results
      def destroy_documents(content_source_key, document_ids)
        document_ids = Array(document_ids)
        post("ent/sources/#{content_source_key}/documents/bulk_destroy.json", document_ids)
      end

      private

      def async_create_or_update_documents(content_source_key, documents)
        post("ent/sources/#{content_source_key}/documents/bulk_create.json", documents)
      end

      def normalize_document(document)
        Utils.stringify_keys(document)
      end
    end

    include SwiftypeEnterprise::Client::ContentSourceDocuments
  end
end
