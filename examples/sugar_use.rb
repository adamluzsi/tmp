require 'tmp'

TMP.write :test2, {hello: 'world'}
puts TMP.read(:test2)

#or you can use syntax sugar!
__tmp__.hello= { hello: 'world'}

# defined variable
puts __tmp__.hello #> { hello: 'world'}

# undefined variable
puts __tmp__.sup #> nil

TMP.purge!

# call after tmp is purged
puts __tmp__.hello #> nil