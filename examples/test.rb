require 'tmp'
require 'securerandom'

tmp= TMP.new File.join TMP.tmpdir,SecureRandom.uuid
$stdout.reopen tmp.test__path__