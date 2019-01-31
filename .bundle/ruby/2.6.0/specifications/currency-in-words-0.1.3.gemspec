# -*- encoding: utf-8 -*-
# stub: currency-in-words 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "currency-in-words".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Bruno Carrere".freeze]
  s.date = "2011-10-18"
  s.description = "Rails 3 helper number_to_currency_in_words that displays a currency amount in words (eg. 'one hundred dollars')".freeze
  s.email = "bruno@carrere.cc".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/bcarrere/currency-in-words".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.1".freeze
  s.summary = "View helper for Rails 3 that displays a currency amount in words (eg. 'one hundred dollars')".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.1"])
      s.add_runtime_dependency(%q<actionpack>.freeze, [">= 3.1"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 3.1"])
      s.add_dependency(%q<actionpack>.freeze, [">= 3.1"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.1"])
    s.add_dependency(%q<actionpack>.freeze, [">= 3.1"])
  end
end
