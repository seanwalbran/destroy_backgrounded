$:.push File.expand_path("../lib", __FILE__)
require "destroy_backgrounded/version"

Gem::Specification.new do |s|
  s.name        = "destroy_backgrounded"
  s.version     = DestroyBackgrounded::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sean Walbran"]
  s.email       = ["seanwalbran@gmail.com"]
  s.homepage    = "http://github.com/seanwalbran/destroy_backgrounded"
  s.summary     = %q{background destroy Rails ActiveRecord objects}
  s.description = %q{destroy database records in the background}

  s.rubyforge_project = "destroy_backgrounded"

  s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.0"])
  s.add_development_dependency(%q<shoulda>, [">= 0"])
  s.add_development_dependency(%q<mocha>, [">= 0"])
  s.add_development_dependency(%q<bundler>, [">= 0"])
  s.add_development_dependency(%q<sqlite3-ruby>, ["~> 1.3.2"])
  s.add_development_dependency(%q<ruby-debug>, [">= 0"])
  s.add_development_dependency(%q<timecop>, [">= 0"])
  s.add_development_dependency(%q<backgrounded>, [">= 0"])

#  s.files         = `git ls-files`.split("\n")
#  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
#  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
