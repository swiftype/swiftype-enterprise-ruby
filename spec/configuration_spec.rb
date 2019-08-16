require 'spec_helper'

describe 'Configuration' do
  context '.endpoint' do
    context 'with a trailing /' do
      it 'adds / to the end of of the URL' do
        Elastic::EnterpriseSearch.endpoint = 'https://api.swiftype.com/api/v1'
        expect(Elastic::EnterpriseSearch.endpoint).to eq('https://api.swiftype.com/api/v1/')
      end
    end

    context 'with a trailing /' do
      it 'leaves the URL alone' do
        Elastic::EnterpriseSearch.endpoint = 'https://api.swiftype.com/api/v1/'
        expect(Elastic::EnterpriseSearch.endpoint).to eq('https://api.swiftype.com/api/v1/')
      end
    end
  end
end
