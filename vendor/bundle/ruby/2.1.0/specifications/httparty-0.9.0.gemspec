# -*- encoding: utf-8 -*-
# stub: httparty 0.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "httparty"
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["John Nunemaker", "Sandro Turriate"]
  s.date = "2012-09-07"
  s.description = "Makes http fun! Also, makes consuming restful web services dead easy."
  s.email = ["nunemaker@gmail.com"]
  s.executables = ["httparty"]
  s.files = ["bin/httparty"]
  s.homepage = "http://jnunemaker.github.com/httparty"
  s.post_install_message = "When you HTTParty, you must party hard!"
  s.rubygems_version = "2.4.6"
  s.summary = "Makes http fun! Also, makes consuming restful web services dead easy."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_runtime_dependency(%q<multi_xml>, [">= 0"])
    else
      s.add_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_dependency(%q<multi_xml>, [">= 0"])
    end
  else
    s.add_dependency(%q<multi_json>, ["~> 1.0"])
    s.add_dependency(%q<multi_xml>, [">= 0"])
  end
end
