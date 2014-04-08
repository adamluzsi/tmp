require 'tmp'

TMP::Config.folder_path File.expand_path(File.join(File.dirname(__FILE__),'tmp_folder'))

# or you can use syntax sugar!
tmp.hello = { hello: 'world'}
# defined variable
puts tmp.hello #> { hello: 'world'}

