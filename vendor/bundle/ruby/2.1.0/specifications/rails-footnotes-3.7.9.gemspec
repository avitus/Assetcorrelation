# -*- encoding: utf-8 -*-
# stub: rails-footnotes 3.7.9 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-footnotes"
  s.version = "3.7.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Roman V. Babenko", "Jos\u{e9} Valim", "Keenan Brock", "Duane Johnson"]
  s.date = "2012-10-27"
  s.description = "Every Rails page has footnotes that gives information about your application and links back to your editor."
  s.email = ["romanvbabenko@gmail.com"]
  s.homepage = "http://github.com/josevalim/rails-footnotes"
  s.rubyforge_project = "rails-footnotes"
  s.rubygems_version = "2.4.6"
  s.summary = "Every Rails page has footnotes that gives information about your application and links back to your editor."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_development_dependency(%q<rails>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.9.0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.9.0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.9.0"])
  end
end
