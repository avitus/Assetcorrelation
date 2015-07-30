# -*- encoding: utf-8 -*-
# stub: newrelic_rpm 3.6.6.147 ruby lib

Gem::Specification.new do |s|
  s.name = "newrelic_rpm"
  s.version = "3.6.6.147"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jason Clark", "Sam Goldstein", "Michael Granger", "Jon Guymon", "Ben Weintraub"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDODCCAiCgAwIBAgIBADANBgkqhkiG9w0BAQUFADBCMREwDwYDVQQDDAhzZWN1\ncml0eTEYMBYGCgmSJomT8ixkARkWCG5ld3JlbGljMRMwEQYKCZImiZPyLGQBGRYD\nY29tMB4XDTEzMDIxMjE5MDcwN1oXDTE0MDIxMjE5MDcwN1owQjERMA8GA1UEAwwI\nc2VjdXJpdHkxGDAWBgoJkiaJk/IsZAEZFghuZXdyZWxpYzETMBEGCgmSJomT8ixk\nARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJyYRvlk1XUo\n8JhWQcE/v6RmpK//JbeKvTKnmWVUKz5oTDSOg/LKEhzChpJJVSOMJHCxd4OoxkIN\npjQF5U2af1m5ONeN1j4p4MujbwNeqxsJmixGLK/BZ9xTnbpYAa6xCRN1UfEcu3O9\njjLHX3c63ghldwRBn/c2ZD6anMtDeq3C5MLiycFs9h7JXOa3cTTHLZknkYIoHMKN\nEFri5zlks50lbeaVvFRm4IMrYWRsEwzLZWaMOy68BVZe0UlBBKSMnzJfWkbdRRcm\nxqu7viu4hrrCGjUmdHKnl6tf7BY7wqQyKjj+O5DhayKmKRuQcEX8QVnsM+ayqiVU\nEtMiwNScUnsCAwEAAaM5MDcwCQYDVR0TBAIwADAdBgNVHQ4EFgQUOauaMsU0Elp6\nhiUisj4l63ZunSUwCwYDVR0PBAQDAgSwMA0GCSqGSIb3DQEBBQUAA4IBAQAuwrHh\njOjIfAQoEbGakiwHTeImqmC1EjBEWb1+U+rC2OcsSQ3+2Q0mGq2u3lAphAeLa6i5\nWXb5OdQqZY2aI7NgMxRG98/+TcIlAT8tDR0e6/+QBlBuDXP3YI5Nuhp5U4LEvghr\njEPaEo0AFPc1JpSO/zKmktU+e9VRAE+q55gLthP8fe0uZvtGUn0KgDbXJyOuGlHF\nJ93N937OcyA2rD8gR1qkr3/0/we1dwLZnL6kN4p8nGzPgXZgOHsmTdYZ2ryYowtb\nKc9+v+QxnbZYpu2IaPXOvm3T8G4O6qZvhnLh/Uien++Dj8eFBecTPoM8pVjK3ph5\nn/EwuZCcE6ghtCCM\n-----END CERTIFICATE-----\n"]
  s.date = "2013-07-25"
  s.description = "New Relic is a performance management system, developed by New Relic,\nInc (http://www.newrelic.com).  New Relic provides you with deep\ninformation about the performance of your web application as it runs\nin production. The New Relic Ruby Agent is dual-purposed as a either a\nGem or plugin, hosted on\nhttp://github.com/newrelic/rpm/\n"
  s.email = "support@newrelic.com"
  s.executables = ["mongrel_rpm", "newrelic_cmd", "newrelic", "nrdebug"]
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.md", "GUIDELINES_FOR_CONTRIBUTING.md", "newrelic.yml"]
  s.files = ["CHANGELOG", "GUIDELINES_FOR_CONTRIBUTING.md", "LICENSE", "README.md", "bin/mongrel_rpm", "bin/newrelic", "bin/newrelic_cmd", "bin/nrdebug", "newrelic.yml"]
  s.homepage = "http://www.github.com/newrelic/rpm"
  s.post_install_message = "# New Relic Ruby Agent Release Notes #\n\n## v3.6.6 ##\n\n* HTTPClient and Curb support\n\n  The Ruby agent now supports the HTTPClient and Curb HTTP libraries! Cross\n  application tracing and more is fully supported for these libraries. For more\n  details see https://newrelic.com/docs/ruby/ruby-http-clients.\n\n* Sinatra startup improvements\n\n  In earlier agent versions, newrelic_rpm had to be required after Sinatra to\n  get instrumentation. Now the agent should start when your Sinatra app starts\n  up in rackup, thin, unicorn, or similar web servers.\n\n* Puma clustered mode support\n\n  Clustered mode in Puma was not reporting data without manually adding a hook\n  to Puma's configuration. The agent will now automatically add this hook.\n\n* SSL certificate verification\n\n  Early versions of the agent's SSL support provided an option to skip\n  certificate verification. This option has been removed.\n\nSee https://github.com/newrelic/rpm/blob/master/CHANGELOG for a full list of\nchanges.\n"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "New Relic Ruby Agent"]
  s.rubygems_version = "2.4.6"
  s.summary = "New Relic Ruby Agent"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["= 10.1.0"])
      s.add_development_dependency(%q<minitest>, ["~> 4.7.5"])
      s.add_development_dependency(%q<mocha>, ["~> 0.13.0"])
      s.add_development_dependency(%q<sdoc-helpers>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 2.4.2"])
      s.add_development_dependency(%q<rails>, ["~> 3.2.13"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<sequel>, ["~> 3.46.0"])
    else
      s.add_dependency(%q<rake>, ["= 10.1.0"])
      s.add_dependency(%q<minitest>, ["~> 4.7.5"])
      s.add_dependency(%q<mocha>, ["~> 0.13.0"])
      s.add_dependency(%q<sdoc-helpers>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 2.4.2"])
      s.add_dependency(%q<rails>, ["~> 3.2.13"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<sequel>, ["~> 3.46.0"])
    end
  else
    s.add_dependency(%q<rake>, ["= 10.1.0"])
    s.add_dependency(%q<minitest>, ["~> 4.7.5"])
    s.add_dependency(%q<mocha>, ["~> 0.13.0"])
    s.add_dependency(%q<sdoc-helpers>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 2.4.2"])
    s.add_dependency(%q<rails>, ["~> 3.2.13"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<sequel>, ["~> 3.46.0"])
  end
end
