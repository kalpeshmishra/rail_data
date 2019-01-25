# -*- encoding: utf-8 -*-
# stub: link_thumbnailer 3.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "link_thumbnailer".freeze
  s.version = "3.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pierre-Louis Gottfrois".freeze]
  s.date = "2018-03-22"
  s.description = "Ruby gem generating thumbnail images from a given URL.".freeze
  s.email = ["pierrelouis.gottfrois@gmail.com".freeze]
  s.homepage = "https://github.com/gottfrois/link_thumbnailer".freeze
  s.rubygems_version = "3.0.1".freeze
  s.summary = "Ruby gem ranking images from a given URL returning an object containing images and website informations.".freeze

  s.installed_by_version = "3.0.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0"])
      s.add_runtime_dependency(%q<json>.freeze, [">= 1.7.7"])
      s.add_runtime_dependency(%q<rake>.freeze, [">= 0.9"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.6"])
      s.add_runtime_dependency(%q<net-http-persistent>.freeze, [">= 2.9"])
      s.add_runtime_dependency(%q<video_info>.freeze, [">= 2.6"])
      s.add_runtime_dependency(%q<image_info>.freeze, [">= 1.0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 3.0"])
      s.add_dependency(%q<json>.freeze, [">= 1.7.7"])
      s.add_dependency(%q<rake>.freeze, [">= 0.9"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 1.6"])
      s.add_dependency(%q<net-http-persistent>.freeze, [">= 2.9"])
      s.add_dependency(%q<video_info>.freeze, [">= 2.6"])
      s.add_dependency(%q<image_info>.freeze, [">= 1.0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0"])
    s.add_dependency(%q<json>.freeze, [">= 1.7.7"])
    s.add_dependency(%q<rake>.freeze, [">= 0.9"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.6"])
    s.add_dependency(%q<net-http-persistent>.freeze, [">= 2.9"])
    s.add_dependency(%q<video_info>.freeze, [">= 2.6"])
    s.add_dependency(%q<image_info>.freeze, [">= 1.0"])
  end
end
