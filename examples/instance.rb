require 'tmp'

tmp_instance= TMP::Instance.new( File.expand_path(File.join(File.dirname(__FILE__),'tmp_folder')) )

tmp_instance.write :test, {hello: 'world'}

puts tmp_instance.read :test
puts TMP.read(:test)  #> must be nil