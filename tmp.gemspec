# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__),"files.rb"))

### Specification for the new Gem
Gem::Specification.new do |spec|

  spec.name          = "tmp"
  spec.version       = File.open(File.join(File.dirname(__FILE__),"VERSION")).read.split("\n")[0].chomp.gsub(' ','')
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.description   = %q{ DSL for system tmp folders }
  spec.summary       = %q{Ruby DSL for manage tmp files and make easy tmp commands / variables accross the forked processes. I'ts not made for shared memory management! it's main }
  spec.homepage      = "https://github.com/adamluzsi/tmp"
  spec.license       = "MIT"

  spec.files         = TMP.class_variable_get("@@spec_files")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'empty_object'

  %W[ rake bundler ].each{ |gem_name| spec.add_development_dependency(gem_name) }

end
