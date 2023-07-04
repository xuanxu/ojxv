# frozen_string_literal: true

require File.expand_path "#{File.dirname(__FILE__)}/lib/ojxv/version"

Gem::Specification.new do |s|
  s.name = "ojxv"
  s.version = OJXV::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = Time.now.strftime('%Y-%m-%d')
  s.authors = ["Juanjo Bazán"]
  s.homepage = 'http://github.com/xuanxu/ojxv'
  s.license = "MIT"
  s.summary = "Open Journals XML Validator"
  s.description = "A library to validate XML outputs in the Open Journals' publishing pipeline"
  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/xuanxu/ojxv/issues",
    "changelog_uri"     => "https://github.com/xuanxu/ojxv/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://www.rubydoc.info/gems/ojxv",
    "homepage_uri"      => s.homepage,
    "source_code_uri"   => s.homepage
  }
  s.files = %w(LICENSE README.md CHANGELOG.md) + Dir.glob("{spec,lib/**/*}") & `git ls-files -z`.split("\0")
  s.require_paths = ["lib"]
  s.rdoc_options = ['--main', 'README.md', '--charset=UTF-8']

  s.add_dependency "nokogiri", "~> 1.15.2"

  s.add_development_dependency "rake", "~> 13.0.6"
  s.add_development_dependency "minitest", "~> 5.18.1"
end
