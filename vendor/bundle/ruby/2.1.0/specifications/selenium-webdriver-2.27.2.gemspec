# -*- encoding: utf-8 -*-
# stub: selenium-webdriver 2.27.2 ruby lib

Gem::Specification.new do |s|
  s.name = "selenium-webdriver"
  s.version = "2.27.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jari Bakken"]
  s.date = "2012-12-10"
  s.description = "WebDriver is a tool for writing automated tests of websites. It aims to mimic the behaviour of a real user, and as such interacts with the HTML of the application."
  s.email = "jari.bakken@gmail.com"
  s.homepage = "http://selenium.googlecode.com"
  s.rubygems_version = "2.4.6"
  s.summary = "The next generation developer focused tool for automated testing of webapps"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_runtime_dependency(%q<rubyzip>, [">= 0"])
      s.add_runtime_dependency(%q<childprocess>, [">= 0.2.5"])
      s.add_runtime_dependency(%q<libwebsocket>, ["~> 0.1.3"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<rack>, ["~> 1.0"])
      s.add_development_dependency(%q<ci_reporter>, ["~> 1.6.2"])
      s.add_development_dependency(%q<webmock>, ["~> 1.7.5"])
    else
      s.add_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_dependency(%q<rubyzip>, [">= 0"])
      s.add_dependency(%q<childprocess>, [">= 0.2.5"])
      s.add_dependency(%q<libwebsocket>, ["~> 0.1.3"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<rack>, ["~> 1.0"])
      s.add_dependency(%q<ci_reporter>, ["~> 1.6.2"])
      s.add_dependency(%q<webmock>, ["~> 1.7.5"])
    end
  else
    s.add_dependency(%q<multi_json>, ["~> 1.0"])
    s.add_dependency(%q<rubyzip>, [">= 0"])
    s.add_dependency(%q<childprocess>, [">= 0.2.5"])
    s.add_dependency(%q<libwebsocket>, ["~> 0.1.3"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<rack>, ["~> 1.0"])
    s.add_dependency(%q<ci_reporter>, ["~> 1.6.2"])
    s.add_dependency(%q<webmock>, ["~> 1.7.5"])
  end
end
