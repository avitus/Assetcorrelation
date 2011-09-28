# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{breadcrumbs_on_rails}
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Simone Carletti}]
  s.date = %q{2011-09-20}
  s.description = %q{BreadcrumbsOnRails is a simple Ruby on Rails plugin for creating and managing a breadcrumb navigation for a Rails project.}
  s.email = %q{weppos@weppos.net}
  s.homepage = %q{http://www.simonecarletti.com/code/breadcrumbs_on_rails}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{A simple Ruby on Rails plugin for creating and managing a breadcrumb navigation.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.10"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_dependency(%q<mocha>, ["~> 0.9.10"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rails>, ["~> 3.0.0"])
    s.add_dependency(%q<mocha>, ["~> 0.9.10"])
  end
end
