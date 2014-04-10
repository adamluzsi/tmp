require 'tmp'

TMP.write :test2, {hello: 'world'}
puts TMP.read(:test2)

#or you can use syntax sugar!
tmp.hello= { hello: 'world'}

tmp.hello do |hello|
  puts 'world'
end

# defined variable
puts tmp.hello #> { hello: 'world'}

# undefined variable
puts tmp.sup #> nil

TMP.purge!

# call after tmp is purged
puts tmp.hello #> nil