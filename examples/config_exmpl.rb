require 'tmp'

TMP.folder_path File.expand_path(File.join(File.dirname(__FILE__),'tmp_folder'))

# except the default folder path, everything is opt able
puts "","default tmp folder:",
     TMP.default_folder_path,"",

     "new tmp folder for use:",
     TMP.folder_path,"",

     "the project name what is used:",
     TMP.project_name,""

# you can trigger the tmp folder generating by the following
TMP.folder_init #> || tmp_folder_init

# or you can use syntax sugar!
__tmp__.hello = { hello: 'world'}

# defined variable
puts __tmp__.hello #> { hello: 'world'}

