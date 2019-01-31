# -*- encoding: utf-8 -*-
# stub: image_info 1.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "image_info".freeze
  s.version = "1.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pierre-Louis Gottfrois".freeze]
  s.bindir = "exe".freeze
  s.date = "2015-08-12"
  s.description = "ImageInfo finds the size and type of a single or multiple images from the web by fetching as little as needed.".freeze
  s.email = ["pierrelouis.gottfrois@gmail.com".freeze]
  s.homepage = "https://github.com/gottfrois/image_info".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.1".freeze
  s.summary = "ImageInfo finds the size and type of a single or multiple images from the web by fetching as little as needed.".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typhoeus>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<image_size>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
    else
      s.add_dependency(%q<typhoeus>.freeze, [">= 0"])
      s.add_dependency(%q<image_size>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<typhoeus>.freeze, [">= 0"])
    s.add_dependency(%q<image_size>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
  end
end
