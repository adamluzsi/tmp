require 'tmp'

TMP.purge!
# using blocks is simply as this
__tmp__.some_file_name "w+" do |file|
  file.write Random.rand(1000...9999)
end

__tmp__.some_file_name do |file|
  puts file.readline #> some random number
end

# reopen the new file is also simple
__tmp__.some_file_name do |file|

  while line = file.gets
    #> some random number same as above
    puts line
  end

end

# you can set the file mod if you like, by default it's based on file e
__tmp__.some_file_name "w+" do |file|

  puts file.readlines.inspect #> [] empty array because the file got w+ command

  file.write "Hello world!"

end

__tmp__.some_file_name do |file|
  puts file.gets.inspect #> "Hello world!"
end

puts __tmp__.some_file_name__path__

puts __tmp__.some_file_name.inspect #> it's a string from the file we made


TMP.purge!.inspect

#> file_with_extension.rb
__tmp__.file_with_extension ext: 'rb' do |file|
  file.write "hello world!"
end

__tmp__.file_with_extension ext: 'rb' do |file|
  puts file.read
end
