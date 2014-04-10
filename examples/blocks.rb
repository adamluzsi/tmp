require 'tmp'

# using blocks is simply as this
tmp.some_file_name do |file|
  file.write Random.rand(100...1000)
end

# reopen the new file is also simple
tmp.some_file_name do |file|

  while line = file.gets
    puts line
  end

  file.write Random.rand(100...1000)

end

# you can set the file mod if you like, by default it's based on file e
tmp.some_file_name "w+" do |file|

  while line = file.gets
    puts line
  end
  # totaly nothing writed out to console because the "w+"

  file.write "hello world!"

end

puts tmp.some_file_name #> it's a string from the file we made