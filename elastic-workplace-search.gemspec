$:.push File.expand_path("../lib", __FILE__)
require "elastic/enterprise-search/version"

Gem::Specification.new do |s|
  s.name        = "elastic-enterprise-search"
  s.version     = Elastic::EnterpriseSearch::VERSION
  s.authors     = ["Quin Hoxie"]
  s.email       = ["support@elastic.co"]
  s.homepage    = "https://github.com/elastic/enterprise-search-ruby"
  s.summary     = %q{Official gem for accessing the Elastic Enterprise Search API}
  s.description = %q{API client for accessing the Elastic Enterprise Search API with no dependencies.}
  s.licenses    = ['Apache-2.0']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 3.0.0'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'vcr', '~> 3.0.3'
  s.add_development_dependency 'webmock'
end
