#encoding: UTF-8
module TMP

  class Instance

    include ConfigCore
    include SupportCore

    def initialize path_string

      unless path_string.class <= String
        raise ArgumentError, "path must be a string like type"
      end

      tmp_folder_path path_string

    end

  end

end