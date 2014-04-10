#encoding: UTF-8
module TMP

  class InstanceCore

    include CORE

    def initialize path_string

      unless path_string.class <= String
        raise ArgumentError, "path must be a string like type"
      end

      folder_path path_string

    end

  end

  class InstanceDSL

    extend ObjectExt
    include DSLCore

    privatize t: 'instance'

    public

    def initialize path_string
      target_obj InstanceCore.new( path_string )
    end

    def tmp_class_instance_object
      target_obj
    end

  end

  class << self

    def new *args
      InstanceDSL.new *args
    end
    alias :init :new

  end

end