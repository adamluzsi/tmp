require 'tmp'

puts __tmp__.random #> nil or empty string because never used or just fresh inited file
puts __tmp__.random__path__ #> path to random named file,
                            # if not exist, make an empty one

puts __tmp__.random__path__ ext: 'rb' #> path to random named file,
