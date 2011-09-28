# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cucumber-rails}
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Aslak Hellesøy}, %q{Dennis Blöte}, %q{Rob Holland}]
  s.date = %q{2011-09-14}
  s.description = %q{Cucumber Generators and Runtime for Rails}
  s.email = %q{cukes@googlegroups.com}
  s.homepage = %q{http://cukes.info}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{cucumber-rails-1.0.5}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cucumber>, ["~> 1.0.6"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_runtime_dependency(%q<capybara>, [">= 1.1.1"])
      s.add_development_dependency(%q<rails>, [">= 3.1.0"])
      s.add_development_dependency(%q<rake>, [">= 0.9.2"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.18"])
      s.add_development_dependency(%q<aruba>, [">= 0.4.6"])
      s.add_development_dependency(%q<sqlite3>, [">= 1.3.4"])
      s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.6.1"])
      s.add_development_dependency(%q<factory_girl>, [">= 2.1.0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0.6.7"])
      s.add_development_dependency(%q<mongoid>, [">= 2.2.0"])
      s.add_development_dependency(%q<bson_ext>, [">= 1.3.1"])
      s.add_development_dependency(%q<turn>, [">= 0.8.2"])
      s.add_development_dependency(%q<sass>, [">= 3.1.7"])
      s.add_development_dependency(%q<coffee-script>, [">= 2.2.0"])
      s.add_development_dependency(%q<uglifier>, [">= 1.0.3"])
      s.add_development_dependency(%q<jquery-rails>, [">= 1.0.14"])
      s.add_development_dependency(%q<yard>, ["~> 0.7.2"])
      s.add_development_dependency(%q<rdiscount>, ["~> 1.6.8"])
      s.add_development_dependency(%q<bcat>, ["~> 0.6.2"])
    else
      s.add_dependency(%q<cucumber>, ["~> 1.0.6"])
      s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_dependency(%q<capybara>, [">= 1.1.1"])
      s.add_dependency(%q<rails>, [">= 3.1.0"])
      s.add_dependency(%q<rake>, [">= 0.9.2"])
      s.add_dependency(%q<bundler>, [">= 1.0.18"])
      s.add_dependency(%q<aruba>, [">= 0.4.6"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.4"])
      s.add_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_dependency(%q<rspec-rails>, [">= 2.6.1"])
      s.add_dependency(%q<factory_girl>, [">= 2.1.0"])
      s.add_dependency(%q<database_cleaner>, [">= 0.6.7"])
      s.add_dependency(%q<mongoid>, [">= 2.2.0"])
      s.add_dependency(%q<bson_ext>, [">= 1.3.1"])
      s.add_dependency(%q<turn>, [">= 0.8.2"])
      s.add_dependency(%q<sass>, [">= 3.1.7"])
      s.add_dependency(%q<coffee-script>, [">= 2.2.0"])
      s.add_dependency(%q<uglifier>, [">= 1.0.3"])
      s.add_dependency(%q<jquery-rails>, [">= 1.0.14"])
      s.add_dependency(%q<yard>, ["~> 0.7.2"])
      s.add_dependency(%q<rdiscount>, ["~> 1.6.8"])
      s.add_dependency(%q<bcat>, ["~> 0.6.2"])
    end
  else
    s.add_dependency(%q<cucumber>, ["~> 1.0.6"])
    s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
    s.add_dependency(%q<capybara>, [">= 1.1.1"])
    s.add_dependency(%q<rails>, [">= 3.1.0"])
    s.add_dependency(%q<rake>, [">= 0.9.2"])
    s.add_dependency(%q<bundler>, [">= 1.0.18"])
    s.add_dependency(%q<aruba>, [">= 0.4.6"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.4"])
    s.add_dependency(%q<rspec>, [">= 2.6.0"])
    s.add_dependency(%q<rspec-rails>, [">= 2.6.1"])
    s.add_dependency(%q<factory_girl>, [">= 2.1.0"])
    s.add_dependency(%q<database_cleaner>, [">= 0.6.7"])
    s.add_dependency(%q<mongoid>, [">= 2.2.0"])
    s.add_dependency(%q<bson_ext>, [">= 1.3.1"])
    s.add_dependency(%q<turn>, [">= 0.8.2"])
    s.add_dependency(%q<sass>, [">= 3.1.7"])
    s.add_dependency(%q<coffee-script>, [">= 2.2.0"])
    s.add_dependency(%q<uglifier>, [">= 1.0.3"])
    s.add_dependency(%q<jquery-rails>, [">= 1.0.14"])
    s.add_dependency(%q<yard>, ["~> 0.7.2"])
    s.add_dependency(%q<rdiscount>, ["~> 1.6.8"])
    s.add_dependency(%q<bcat>, ["~> 0.6.2"])
  end
end
