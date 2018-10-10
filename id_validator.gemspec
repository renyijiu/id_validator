
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "id_validator/version"

Gem::Specification.new do |spec|
  spec.name          = "id_validator"
  spec.version       = IdValidator::VERSION
  spec.authors       = ["renyijiu"]
  spec.email         = ["lanyuejin1108@gmail.com"]

  spec.summary       = %q{Chinese Mainland Personal ID Card Validation.}
  spec.description   = %q{A Ruby Gem For Chinese Mainland Personal ID Card Validation}
  spec.homepage      = "https://github.com/renyijiu/id_validator"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
