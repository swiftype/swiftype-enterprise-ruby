require 'spec_helper'

describe Elastic::WorkplaceSearch::Client::Permissions do
  let(:client) { Elastic::WorkplaceSearch::Client.new }

  before :each do
    Elastic::WorkplaceSearch.access_token = 'xyT3mm3ecPsPuYxd_6fX'
  end

  let(:content_source_key) { '5d96387b75444bf49532c24a' }
  let(:user) { 'enterprise_search' }

  context '#list_all_permissions' do
    it 'lists all permissions' do
      VCR.use_cassette(:list_all_permissions) do
        response = client.list_all_permissions(content_source_key)
        expect(response['results'].size).to eq(2)
      end
    end

    it 'lists all permissions with paging' do
      VCR.use_cassette(:list_all_permissions_with_paging) do
        response = client.list_all_permissions(content_source_key, :current => 2, :size => 5)
        expect(response['meta']['page']['current']).to eq(2)
        expect(response['meta']['page']['size']).to eq(5)
        expect(response['results'].size).to eq(0)
      end
    end
  end

  context '#add_user_permissions' do
    let(:permissions) { ['permission1'] }

    it 'adds permissions to a user' do
      VCR.use_cassette(:add_user_permissions) do
        response = client.add_user_permissions(content_source_key, user, :permissions => permissions)
        expect(response['permissions']).to eq(['permission1'])
      end
    end
  end

  context '#get_user_permissions' do
    let(:permissions) { ['permission1'] }

    it 'gets permissions for a user' do
      VCR.use_cassette(:get_user_permissions) do
        response = client.get_user_permissions(content_source_key, user)
        expect(response['permissions']).to eq(['permission1'])
      end
    end
  end

  context '#update_user_permissions' do
    let(:permissions) { ['permission2'] }

    it 'updates permissions for a user' do
      VCR.use_cassette(:update_user_permissions) do
        response = client.update_user_permissions(content_source_key, user, :permissions => permissions)
        expect(response['permissions']).to eq(['permission2'])
      end
    end
  end

  context '#remove_user_permissions' do
    let(:permissions) { ['permission2'] }

    it 'removes permissions from a user' do
      VCR.use_cassette(:remove_user_permissions) do
        response = client.remove_user_permissions(content_source_key, user, :permissions => permissions)
        expect(response['permissions']).to eq([])
      end
    end
  end

end
