# frozen_string_literal: true

require 'spec_helper'

describe Elastic::WorkplaceSearch::Client do
  let(:client) { Elastic::WorkplaceSearch::Client.new }
  let(:response) { { 'status' => 'ok' } }
  let(:stub_response) { { body: response.to_json } }
  let(:host) { 'http://localhost:3002/api/ws/v1' }
  let(:access_token) { 'access_token' }
  let(:user_agent) do
    [
      "#{Elastic::WorkplaceSearch::CLIENT_NAME}/#{Elastic::WorkplaceSearch::VERSION} ",
      "(RUBY_VERSION: #{RUBY_VERSION}; ",
      "#{RbConfig::CONFIG['host_os'].split('_').first[/[a-z]+/i].downcase} ",
      "#{RbConfig::CONFIG['target_cpu']})"
    ].join
  end

  let(:headers) do
    {
      'User-Agent' => user_agent,
      'Content-Type' => 'application/json',
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

  context 'with a proxy' do
    # TODO: webmok doesn't seem to support checking if request was sent through
    # a proxy yet.
    let(:proxy) { 'http://localhost:8888' }
    let(:client) { Elastic::WorkplaceSearch::Client.new(proxy: proxy) }

    it 'sends the request correctly' do
      stub_request(:get, "#{host}/test")
        .with(query: { 'params' => 'test' }, headers: headers)
        .to_return(stub_response)

      expect(client.get('test', { 'params' => 'test' })).to eq(response)
    end
  end

  context 'with ssl' do
    let(:host) { 'https://localhost:3002/api/ws/v1' }

    before do
      Elastic::WorkplaceSearch.endpoint = host
    end

    it 'sends the request correctly' do
      stub_request(:get, "#{host}/test")
        .with(query: { 'params' => 'test' }, headers: headers)
        .to_return(stub_response)

      expect(client.get('test', { 'params' => 'test' })).to eq(response)
    end
  end
end
