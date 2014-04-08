# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__),"files.rb"))

### Specification for the new Gem
Gem::Specification.new do |spec|

  spec.name          = "tmp"
  spec.version       = File.open(File.join(File.dirname(__FILE__),"VERSION")).read.split("\n")[0].chomp.gsub(' ','')
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.description   = %q{ Ruby DSL for manage tmp files and make easy tmp commands / variables to file system. Sometimes usefull for forked processes. I'ts not made for shared memory management! The main goal is to provide dsl for easy tmp files making on the filesystem }
  spec.summary       = %q{ DSL for system temporary folder to save objects }
  spec.homepage      = "https://github.com/adamluzsi/tmp"
  spec.license       = "MIT"

  spec.files         = TMP.class_variable_get("@@spec_files")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'empty_object'

  %W[ rake bundler ].each{ |gem_name| spec.add_development_dependency(gem_name) }

end
