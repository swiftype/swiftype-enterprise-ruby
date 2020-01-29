module Elastic
  module WorkplaceSearch
    class Client
      module ContentSourceDocuments

        # Index a batch of documents.
        #
        # @param [String] content_source_key the unique Content Source key as found in your Content Sources dashboard
        # @param [Array] documents an Array of Document Hashes
        #
        # @return [Array<Hash>] an Array of Document indexing Results
        #
        # @raise [Elastic::WorkplaceSearch::InvalidDocument] when a single document is missing required fields or contains unsupported fields
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
          post("sources/#{content_source_key}/documents/bulk_destroy.json", document_ids)
        end

        private

        def async_create_or_update_documents(content_source_key, documents)
          post("sources/#{content_source_key}/documents/bulk_create.json", documents)
        end

        def normalize_document(document)
          Utils.stringify_keys(document)
        end
      end
    end
  end
end
