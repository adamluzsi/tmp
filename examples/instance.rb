require 'tmp'


tmp_instance= TMP.new( File.expand_path(File.join(File.dirname(__FILE__),'tmp_folder')) )

# use the same as the TMP::DSL aka tmp method

# let's set a string for this one
tmp_instance.test= "hello"

# get the string what we just set now
tmp_instance.test #> "hello"

# you can get the tmp class instance obj like this:
tmp_instance.tmp_class_instance_object #> return the tmp_instance

# return the tmp folder path
tmp_instance.tmp_class_instance_object.folder_path

# Remember this instance use different folder thant the main TMP::DSL
tmp.test.inspect  #> nil, because it was never used before
                  #> the tmp method is same like invoke the TMP::DSL module
