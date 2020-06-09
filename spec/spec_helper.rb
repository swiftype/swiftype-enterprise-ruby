# frozen_string_literal: true

require 'bundler/setup'
require 'rspec'
require 'webmock'
require 'vcr'
require 'awesome_print'
require 'elastic/workplace_search'

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  ENDPOINT = ENV['ENDPOINT'] || 'http://localhost:3002/api/ws/v1'

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/vcr'
    c.hook_into :webmock
  end

  config.before :each do
    Elastic::WorkplaceSearch.endpoint = ENDPOINT
  end

  config.after :each do
    Elastic::WorkplaceSearch.reset
  end
end
