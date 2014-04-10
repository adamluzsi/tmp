exp_path= File.expand_path( File.join( File.dirname(__FILE__), '..','lib','tmp'))

require 'tmpdir'

%W[
  core.rb
  sup.rb

  dsl.rb
  init.rb
].each{ |p| require File.join(exp_path,p) }


tmp_folder= TMP.new File.expand_path( File.join( File.dirname(__FILE__),'tmp_folder'))

puts tmp_folder.tmp_class_instance_object #folder_path

#tmp_folder.test= 123
