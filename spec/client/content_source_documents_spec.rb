# frozen_string_literal: true

require 'spec_helper'

describe Elastic::WorkplaceSearch::Client::ContentSourceDocuments do
  let(:engine_slug) { 'workplace-search-api-example' }
  let(:client) { Elastic::WorkplaceSearch::Client.new }

  before :each do
    Elastic::WorkplaceSearch.access_token = 'cGUN-vBokevBhhzyA669'
  end

  def check_receipt_response_format(response, options = {})
    expect(response.keys).to match_array(['document_receipts', 'batch_link'])
    expect(response['document_receipts']).to be_a_kind_of(Array)
    expect(response['document_receipts'].first.keys).to match_array(['id', 'id', 'links', 'status', 'errors'])
    expect(response['document_receipts'].first['id']).to eq(options[:id]) if options[:id]
    expect(response['document_receipts'].first['status']).to eq(options[:status]) if options[:status]
    expect(response['document_receipts'].first['errors']).to eq(options[:errors]) if options[:errors]
  end

  let(:content_source_key) { '59542d332139de0acacc7dd4' }
  let(:documents) do
    [{ 'id' => 'INscMGmhmX4',
       'url' => 'http://www.youtube.com/watch?v=v1uyQZNg2vE',
       'title' => 'The Original Grumpy Cat',
       'body' => 'this is a test' },
     { 'id' => 'JNDFojsd02',
       'url' => 'http://www.youtube.com/watch?v=tsdfhk2j',
       'title' => 'Another Grumpy Cat',
       'body' => 'this is also a test' }]
  end

  context '#index_documents' do
    it 'returns results when successful' do
      VCR.use_cassette(:async_create_or_update_document_success) do
        response = client.index_documents(content_source_key, documents)
        expect(response.size).to eq(2)
      end
    end
  end

  context '#destroy_documents' do
    it 'returns #async_create_or_update_documents format return when async has been passed as true' do
      VCR.use_cassette(:async_create_or_update_document_success) do
        VCR.use_cassette(:document_receipts_multiple_complete) do
          client.index_documents(content_source_key, documents)
          VCR.use_cassette(:destroy_documents_success) do
            response = client.destroy_documents(content_source_key, [documents.first['id']])
            expect(response.size).to eq(1)
            expect(response.first['success']).to eq(true)
          end
        end
      end
    end
  end
end
