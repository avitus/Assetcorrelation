# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cucumber}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Aslak Hellesøy}]
  s.date = %q{2011-09-13}
  s.description = %q{Behaviour Driven Development with elegance and joy}
  s.email = %q{cukes@googlegroups.com}
  s.executables = [%q{cucumber}]
  s.files = [%q{bin/cucumber}]
  s.homepage = %q{http://cukes.info}
  s.post_install_message = %q{
(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

Thank you for installing cucumber-1.0.6.
Please be sure to read http://wiki.github.com/cucumber/cucumber/upgrading
for important information about this release. Happy cuking!

(::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::) (::)

}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{cucumber-1.0.6}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gherkin>, ["~> 2.4.18"])
      s.add_runtime_dependency(%q<term-ansicolor>, [">= 1.0.6"])
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 1.1.2"])
      s.add_runtime_dependency(%q<json>, [">= 1.4.6"])
      s.add_development_dependency(%q<aruba>, ["~> 0.4.6"])
      s.add_development_dependency(%q<rake>, [">= 0.9.2"])
      s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_development_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_development_dependency(%q<prawn>, ["~> 0.8.4"])
      s.add_development_dependency(%q<prawn-layout>, ["~> 0.8.4"])
      s.add_development_dependency(%q<syntax>, [">= 1.0.0"])
      s.add_development_dependency(%q<spork>, [">= 0.9.0.rc9"])
      s.add_development_dependency(%q<simplecov>, [">= 0.4.2"])
      s.add_development_dependency(%q<yard>, ["~> 0.7.2"])
      s.add_development_dependency(%q<rdiscount>, ["~> 1.6.8"])
      s.add_development_dependency(%q<bcat>, ["~> 0.6.1"])
      s.add_development_dependency(%q<ramaze>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0.5.7"])
      s.add_development_dependency(%q<webrat>, [">= 0.7.3"])
      s.add_development_dependency(%q<sinatra>, [">= 1.2.6"])
      s.add_development_dependency(%q<capybara>, [">= 1.1.0"])
    else
      s.add_dependency(%q<gherkin>, ["~> 2.4.18"])
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.6"])
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
      s.add_dependency(%q<json>, [">= 1.4.6"])
      s.add_dependency(%q<aruba>, ["~> 0.4.6"])
      s.add_dependency(%q<rake>, [">= 0.9.2"])
      s.add_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_dependency(%q<prawn>, ["~> 0.8.4"])
      s.add_dependency(%q<prawn-layout>, ["~> 0.8.4"])
      s.add_dependency(%q<syntax>, [">= 1.0.0"])
      s.add_dependency(%q<spork>, [">= 0.9.0.rc9"])
      s.add_dependency(%q<simplecov>, [">= 0.4.2"])
      s.add_dependency(%q<yard>, ["~> 0.7.2"])
      s.add_dependency(%q<rdiscount>, ["~> 1.6.8"])
      s.add_dependency(%q<bcat>, ["~> 0.6.1"])
      s.add_dependency(%q<ramaze>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0.5.7"])
      s.add_dependency(%q<webrat>, [">= 0.7.3"])
      s.add_dependency(%q<sinatra>, [">= 1.2.6"])
      s.add_dependency(%q<capybara>, [">= 1.1.0"])
    end
  else
    s.add_dependency(%q<gherkin>, ["~> 2.4.18"])
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.6"])
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
    s.add_dependency(%q<json>, [">= 1.4.6"])
    s.add_dependency(%q<aruba>, ["~> 0.4.6"])
    s.add_dependency(%q<rake>, [">= 0.9.2"])
    s.add_dependency(%q<rspec>, [">= 2.6.0"])
    s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
    s.add_dependency(%q<prawn>, ["~> 0.8.4"])
    s.add_dependency(%q<prawn-layout>, ["~> 0.8.4"])
    s.add_dependency(%q<syntax>, [">= 1.0.0"])
    s.add_dependency(%q<spork>, [">= 0.9.0.rc9"])
    s.add_dependency(%q<simplecov>, [">= 0.4.2"])
    s.add_dependency(%q<yard>, ["~> 0.7.2"])
    s.add_dependency(%q<rdiscount>, ["~> 1.6.8"])
    s.add_dependency(%q<bcat>, ["~> 0.6.1"])
    s.add_dependency(%q<ramaze>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0.5.7"])
    s.add_dependency(%q<webrat>, [">= 0.7.3"])
    s.add_dependency(%q<sinatra>, [">= 1.2.6"])
    s.add_dependency(%q<capybara>, [">= 1.1.0"])
  end
end
