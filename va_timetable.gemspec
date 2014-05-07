# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'va_timetable/version'

Gem::Specification.new do |spec|
  spec.name          = "va_timetable"
  spec.version       = VaTimetable::VERSION
  spec.date          = "2014-05-07"
  spec.authors       = ["Paul Jackson"]
  spec.email         = ["pjackson@mbs-projects.com"]
  spec.summary       = "Return Virgin Active workout classes"
  spec.description   = "Uses Nokogiri for parsing classes from the Virgin Active website(s)"
  spec.homepage      = "http://github.com/jacksop/va_timetable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "nokogiri"
end
