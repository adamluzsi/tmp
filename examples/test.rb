require 'tmp'

TMP.write :test, {hello: 'world'}
puts TMP.read(:test)

# or you can use syntax sugar!
tmp.hello = { hello: 'world'}

# defined variable
puts tmp.hello #> { hello: 'world'}

# undefined variable
puts tmp.sup #> nil

TMP.purge!

# call after tmp is purged
puts tmp.hello #> nil