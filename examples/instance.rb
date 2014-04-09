require 'tmp'

tmp_instance= TMP.new( File.expand_path(File.join(File.dirname(__FILE__),'tmp_folder')) )

tmp_instance.test= "hello"

# get the instance test variable
puts tmp_instance.test.inspect #> this must be "hello"

# get the main TMP test variable
puts tmp.test.inspect  #> must be nil because it was never used before
                       #> same as TMP::DSL.test.inspect