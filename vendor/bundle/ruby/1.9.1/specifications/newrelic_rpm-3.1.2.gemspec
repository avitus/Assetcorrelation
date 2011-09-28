# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{newrelic_rpm}
  s.version = "3.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Bill Kayser}, %q{Jon Guymon}, %q{Justin George}, %q{Darin Swanson}]
  s.date = %q{2011-09-07}
  s.description = %q{New Relic is a performance management system, developed by New Relic,
Inc (http://www.newrelic.com).  New Relic provides you with deep
information about the performance of your web application as it runs
in production. The New Relic Ruby Agent is dual-purposed as a either a
Gem or plugin, hosted on
http://github.com/newrelic/rpm/
}
  s.email = %q{support@newrelic.com}
  s.executables = [%q{mongrel_rpm}, %q{newrelic}, %q{newrelic_cmd}]
  s.extra_rdoc_files = [%q{CHANGELOG}, %q{LICENSE}, %q{README.rdoc}, %q{newrelic.yml}]
  s.files = [%q{bin/mongrel_rpm}, %q{bin/newrelic}, %q{bin/newrelic_cmd}, %q{CHANGELOG}, %q{LICENSE}, %q{README.rdoc}, %q{newrelic.yml}]
  s.homepage = %q{http://www.github.com/newrelic/rpm}
  s.post_install_message = %q{
PLEASE NOTE:

Developer Mode is now a Rack middleware.

Developer Mode is no longer available in Rails 2.1 and earlier.
However, starting in version 2.12 you can use Developer Mode in any
Rack based framework, in addition to Rails.  To install developer mode
in a non-Rails application, just add NewRelic::Rack::DeveloperMode to
your middleware stack.

If you are using JRuby, we recommend using at least version 1.4 or 
later because of issues with the implementation of the timeout library.

Refer to the README.md file for more information.

Please see http://github.com/newrelic/rpm/blob/master/CHANGELOG
for a complete description of the features and enhancements available
in version 3.1 of the Ruby Agent.
  
}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{New Relic Ruby Agent}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{New Relic Ruby Agent}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
    else
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
  end
end
