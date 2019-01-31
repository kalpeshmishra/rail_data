# -*- encoding: utf-8 -*-
# stub: sum_strings 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "sum_strings".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["nezir".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-10-01"
  s.description = "With this gem you are able to sum array of strings values. Primary ment for summing array of hours in format [\"20:25\",\"10:10\"].strings_to_sum(':') which will result as \"30:35\" hours/minutes. ".freeze
  s.email = ["nezir.zahirovic@gmail.com".freeze]
  s.homepage = "https://github.com/nezirz/sum_strings".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.1".freeze
  s.summary = "Gem for summing string values from arrays.".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
