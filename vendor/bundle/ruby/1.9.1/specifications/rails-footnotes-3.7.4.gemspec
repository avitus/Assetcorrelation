# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails-footnotes}
  s.version = "3.7.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Keenan Brock}]
  s.date = %q{2011-05-26}
  s.description = %q{Every Rails page has footnotes that gives information about your application and links back to your editor.}
  s.email = [%q{keenan@thebrocks.net}]
  s.homepage = %q{http://github.com/josevalim/rails-footnotes}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{rails-footnotes}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Every Rails page has footnotes that gives information about your application and links back to your editor.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_development_dependency(%q<rails>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<watchr>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<watchr>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<watchr>, [">= 0"])
  end
end
