# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require "sec_entities/version"
require "sec_entities"

Gem::Specification.new do |s|
  s.name        = "sec_entities"
  s.version     = SecQuery::VERSION
  s.authors     = ["Ty Rauber"]
  s.email       = ["tyrauber@mac.com"]
  s.homepage    = "https://github.com/ballantyne/sec_entities"
  s.summary     = "A ruby gem for querying the United States Securities and Exchange Commission Edgar System."
  s.description = "This gem was originally made by Ty Rauber and had more functions, but I couldn't get to work and I didn't need all of the functions so I made it work for what I needed."

  s.rubyforge_project = "sec_query"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
   s.add_development_dependency "rspec"
   s.add_runtime_dependency "rest-client"
   s.add_runtime_dependency "nokogiri"
   s.add_runtime_dependency "hashie"
   s.add_runtime_dependency "crack"

end
