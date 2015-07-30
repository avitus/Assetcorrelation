# -*- encoding: utf-8 -*-
# stub: topsy 0.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "topsy"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Wynn Netherland", "Ernesto Tagwerker"]
  s.date = "2011-01-07"
  s.description = "Wrapper for the Topsy API"
  s.email = "wynn.netherland@gmail.com"
  s.homepage = "http://wynnnetherland.com/projects/topsy/"
  s.rubygems_version = "2.4.6"
  s.summary = "Ruby wrapper for the Topsy API"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hashie>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.8.1"])
      s.add_development_dependency(%q<shoulda>, ["~> 2.11.3"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.10"])
      s.add_development_dependency(%q<fakeweb>, ["~> 1.3.0"])
      s.add_development_dependency(%q<jnunemaker-matchy>, ["~> 0.4.0"])
    else
      s.add_dependency(%q<hashie>, ["~> 1.2.0"])
      s.add_dependency(%q<httparty>, [">= 0.8.1"])
      s.add_dependency(%q<shoulda>, ["~> 2.11.3"])
      s.add_dependency(%q<mocha>, ["~> 0.9.10"])
      s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
      s.add_dependency(%q<jnunemaker-matchy>, ["~> 0.4.0"])
    end
  else
    s.add_dependency(%q<hashie>, ["~> 1.2.0"])
    s.add_dependency(%q<httparty>, [">= 0.8.1"])
    s.add_dependency(%q<shoulda>, ["~> 2.11.3"])
    s.add_dependency(%q<mocha>, ["~> 0.9.10"])
    s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
    s.add_dependency(%q<jnunemaker-matchy>, ["~> 0.4.0"])
  end
end
