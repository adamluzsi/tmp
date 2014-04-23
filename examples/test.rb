require 'tmp'

__TMP__.test= {hello: "world"}

puts __TMP__.test
__TMP__.test= nil
puts __TMP__.test.inspect