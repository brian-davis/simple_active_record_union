# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_active_record_union/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_active_record_union"
  spec.version       = SimpleActiveRecordUnion::VERSION
  spec.authors       = ["Brian Davis"]
  spec.email         = ["g_brian_davis@protonmail.com"]

  spec.summary       = %q{Adds convenience UNION and UNION ALL query class methods to ActiveRecord::Base models.}
  spec.description   = %q{Adds convenience UNION and UNION ALL query class methods to ActiveRecord::Base models.}
  spec.homepage      = "https://github.com/brian-davis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "activerecord"
end
