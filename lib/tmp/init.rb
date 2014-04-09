#encoding: UTF-8
module TMP

  class InstanceCore

    include CORE

    def initialize path_string

      unless path_string.class <= String
        raise ArgumentError, "path must be a string like type"
      end

      tmp_folder_path path_string

    end

  end

  class InstanceDSL < ::EmptyObject
    include DSLCore

    def initialize path_string
      @class_name = InstanceCore.new path_string
    end

  end

  class << self

    def new *args
      InstanceDSL.new *args
    end

    alias :init :new

  end

end