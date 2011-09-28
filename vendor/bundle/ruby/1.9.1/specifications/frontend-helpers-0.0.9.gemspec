# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{frontend-helpers}
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Christopher Hein}]
  s.date = %q{2011-09-20}
  s.description = %q{Large collection of useful Rails 3.1 helpers for SEO, Metatags, Facebook OG tags, integration for analytics services like google, woopra, olark, mixpanel and much much more...}
  s.email = %q{me@christopherhein.com}
  s.extra_rdoc_files = [%q{LICENSE.txt}, %q{README.md}]
  s.files = [%q{LICENSE.txt}, %q{README.md}]
  s.homepage = %q{http://github.com/christopherhein/frontend-helpers}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Collection of useful frontend helpers for Rails 3.1 applications.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.1.0"])
      s.add_runtime_dependency(%q<haml-rails>, [">= 0"])
      s.add_runtime_dependency(%q<sass-rails>, [">= 0"])
      s.add_runtime_dependency(%q<sprockets>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.1.0"])
      s.add_dependency(%q<haml-rails>, [">= 0"])
      s.add_dependency(%q<sass-rails>, [">= 0"])
      s.add_dependency(%q<sprockets>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.1.0"])
    s.add_dependency(%q<haml-rails>, [">= 0"])
    s.add_dependency(%q<sass-rails>, [">= 0"])
    s.add_dependency(%q<sprockets>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end
