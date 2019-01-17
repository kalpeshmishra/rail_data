# -*- encoding: utf-8 -*-
# stub: video_info 2.7 ruby lib

Gem::Specification.new do |s|
  s.name = "video_info".freeze
  s.version = "2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thibaud Guillaume-Gentil".freeze]
  s.date = "2017-01-09"
  s.description = "Get video info from Dailymotion, Vimeo, VK and YouTube url.".freeze
  s.email = "thibaud@thibaud.gg".freeze
  s.homepage = "https://rubygems.org/gems/video_info".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.0.1".freeze
  s.summary = "Dailymotion, Vimeo, VK and YouTube info parser.".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<iso8601>.freeze, ["~> 0.9.1"])
      s.add_runtime_dependency(%q<oga>.freeze, ["~> 2.7"])
      s.add_runtime_dependency(%q<net_http_timeout_errors>.freeze, ["~> 0.3.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.3.5"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 11.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_development_dependency(%q<rspec-its>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.37"])
      s.add_development_dependency(%q<vcr>.freeze, ["~> 3.0.3"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1.24"])
    else
      s.add_dependency(%q<iso8601>.freeze, ["~> 0.9.1"])
      s.add_dependency(%q<oga>.freeze, ["~> 2.7"])
      s.add_dependency(%q<net_http_timeout_errors>.freeze, ["~> 0.3.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.3.5"])
      s.add_dependency(%q<rake>.freeze, ["~> 11.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
      s.add_dependency(%q<rspec-its>.freeze, ["~> 1.2"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.37"])
      s.add_dependency(%q<vcr>.freeze, ["~> 3.0.3"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1.24"])
    end
  else
    s.add_dependency(%q<iso8601>.freeze, ["~> 0.9.1"])
    s.add_dependency(%q<oga>.freeze, ["~> 2.7"])
    s.add_dependency(%q<net_http_timeout_errors>.freeze, ["~> 0.3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.3.5"])
    s.add_dependency(%q<rake>.freeze, ["~> 11.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.4"])
    s.add_dependency(%q<rspec-its>.freeze, ["~> 1.2"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.37"])
    s.add_dependency(%q<vcr>.freeze, ["~> 3.0.3"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.24"])
  end
end
