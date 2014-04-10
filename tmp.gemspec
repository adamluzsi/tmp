# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__),"files.rb"))

### Specification for the new Gem
Gem::Specification.new do |spec|

  spec.name          = "tmp"
  spec.version       = File.open(File.join(File.dirname(__FILE__),"VERSION")).read.split("\n")[0].chomp.gsub(' ','')
  spec.authors       = ["Adam Luzsi"]
  spec.email         = ["adamluzsi@gmail.com"]
  spec.description   = %q{ DSL for temporally files read/write in the object oriented way (system tmp). Manage tmp files in the super easy way! This dsl let you have simply way to commands and create variables on file system by default in the actual systems (cross platform) tmp folder. Sometimes it can be useful for multi processing (forked processes), but the main goal is not made for shared memory management! The goal is to provide dsl for easy tmp files making on the filesystem in the object oriented way (real objects and not simply strings). By default i's always IO work and not memory, everything you save with this will be IO command and not memory }
  spec.summary       = %q{ DSL for temporally files read/write in the object oriented way (system tmp) }
  spec.homepage      = "https://github.com/adamluzsi/tmp"
  spec.license       = "MIT"

  spec.files         = TMP.class_variable_get("@@spec_files")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency 'empty_object'

  %W[ rake bundler ].each{ |gem_name| spec.add_development_dependency(gem_name) }

end
