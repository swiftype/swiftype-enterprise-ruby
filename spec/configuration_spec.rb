# frozen_string_literal: true

require 'spec_helper'

describe 'Configuration' do
  context '.endpoint' do
    context 'with a trailing /' do
      it 'adds / to the end of of the URL' do
        Elastic::WorkplaceSearch.endpoint = 'https://api.swiftype.com/api/ws/v1'
        expect(Elastic::WorkplaceSearch.endpoint).to eq('https://api.swiftype.com/api/ws/v1/')
      end
    end

    context 'with a trailing /' do
      it 'leaves the URL alone' do
        Elastic::WorkplaceSearch.endpoint = 'https://api.swiftype.com/api/ws/v1/'
        expect(Elastic::WorkplaceSearch.endpoint).to eq('https://api.swiftype.com/api/ws/v1/')
      end
    end
  end
end
