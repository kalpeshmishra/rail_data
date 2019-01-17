# -*- encoding: utf-8 -*-
# stub: net_http_timeout_errors 0.3.3 ruby lib

Gem::Specification.new do |s|
  s.name = "net_http_timeout_errors".freeze
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Henrik Nyh".freeze]
  s.date = "2018-07-17"
  s.email = ["henrik@nyh.se".freeze]
  s.homepage = "https://github.com/barsoom/net_http_timeout_errors".freeze
  s.rubygems_version = "3.0.1".freeze
  s.summary = "Provides a list of Net::HTTP timeout errors.".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
  end
end
