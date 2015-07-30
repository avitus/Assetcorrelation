# -*- encoding: utf-8 -*-
# stub: rails_autolink 1.0.9 ruby lib

Gem::Specification.new do |s|
  s.name = "rails_autolink"
  s.version = "1.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Aaron Patterson", "Juanjo Bazan", "Akira Matsuda"]
  s.date = "2012-05-26"
  s.description = "This is an extraction of the `auto_link` method from rails.  The `auto_link`\nmethod was removed from Rails in version Rails 3.1.  This gem is meant to\nbridge the gap for people migrating."
  s.email = ["aaron@tenderlovemaking.com", "jjbazan@gmail.com", "ronnie@dio.jp"]
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "Manifest.txt", "README.rdoc"]
  s.files = ["CHANGELOG.rdoc", "Manifest.txt", "README.rdoc"]
  s.homepage = "http://github.com/tenderlove/rails_autolink"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.rubyforge_project = "rails_autolink"
  s.rubygems_version = "2.4.6"
  s.summary = "This is an extraction of the `auto_link` method from rails"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.1"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 3.0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.1"])
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.1"])
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 3.0"])
  end
end
