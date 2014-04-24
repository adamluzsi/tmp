require 'tmp'

puts __TMP__.random #> nil or empty string because never used or just fresh inited file
puts __TMP__.random__path__ #> path to random named file,
                            # if not exist, make an empty one
