require 'spec_helper'

describe Elastic::WorkplaceSearch::Client do
  let(:client) { Elastic::WorkplaceSearch::Client.new }
  let(:response) { { 'status' => 'ok' } }
  let(:stub_response) { { body: response.to_json } }
  let(:host) { 'http://localhost:3002/api/ws/v1' }
  let(:access_token) { 'cGUN-vBokevBhhzyA669' }
  let(:headers) do
    {
      'User-Agent' => 'Ruby',
      'Content-Type' => 'application/json',
      'X-Swiftype-Client' => Elastic::WorkplaceSearch::CLIENT_NAME,
      'X-Swiftype-Client-Version' => Elastic::WorkplaceSearch::CLIENT_VERSION,
      'Authorization' => "Bearer #{access_token}"
    }
  end

  before :each do
    Elastic::WorkplaceSearch.access_token = access_token
  end

  context 'builds request' do
    context 'get' do
      it 'builds the right request' do
        stub_request(:get, "#{host}/test")
          .with(query: { 'params' => 'test' }, headers: headers)
          .to_return(stub_response)

        expect(client.get('test', { 'params' => 'test' })).to eq(response)
      end
    end

    context 'delete' do
      it 'builds the right request' do
        stub_request(:delete, "#{host}/test")
          .with(query: { 'params' => 'test' }, headers: headers)
          .to_return(stub_response)

        expect(client.delete('test', { 'params' => 'test' })).to eq(response)
      end
    end

    context 'post' do
      it 'builds the right request' do
        stub_request(:post, "#{host}/test")
          .with(body: { 'params' => 'test' }, headers: headers)
          .to_return(stub_response)

        expect(client.post('test', { 'params' => 'test' })).to eq(response)
      end
    end

    context 'put' do
      it 'builds the right request' do
        stub_request(:put, "#{host}/test")
          .with(body: { 'params' => 'test' }, headers: headers)
          .to_return(stub_response)

        expect(client.put('test', { 'params' => 'test' })).to eq(response)
      end
    end
  end
end
