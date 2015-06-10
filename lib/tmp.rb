#encoding: UTF-8
module TMP

  require 'tmp/instance'

  require 'tmp/deprecated/core'
  require 'tmp/deprecated/sup'

  require 'tmp/deprecated/dsl'
  require 'tmp/deprecated/init'

  def self.new(*args)
    Instance.new(*args)
  end

end
