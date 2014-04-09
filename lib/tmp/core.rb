#encoding: UTF-8
module TMP

  module CORE

    def default_folder_path
      File.join( Dir.tmpdir, ( Dir.pwd.split(File::Separator).last.to_s  ) )
    end

    @folder_path= nil
    def folder_path path_string= nil

      unless path_string.nil?

        unless path_string.class <= String
          raise ArgumentError,"invalid path class, must be string like"
        end

        @folder_path = File.absolute_path(path_string)

      end

      @folder_path || default_folder_path

    end

    alias :tmp_folder_path :folder_path

    def tmp_folder_init

      begin

        Dir.mkdir tmp_folder_path
        return true

      rescue Errno::EEXIST
        return false
      end

    end

    def write variable_name, data_object

      tmp_folder_init

      File.open( File.join(tmp_folder_path,variable_name.to_s) ,"w") do |file|
        return file.write ::Marshal.dump(data_object)
      end

    end

    def read variable_name

      unless File.exist?(File.join(tmp_folder_path,variable_name.to_s))
        return nil
      end

      File.open( File.join(tmp_folder_path,variable_name.to_s) ,"r") do |file|
        return ::Marshal.load file.read
      end

    end

    def purge_files

      Dir.glob( File.join( tmp_folder_path,'**','*' ) ).each do |file_path|

        begin
          File.delete file_path
        rescue Errno::ENOENT
        end

      end

    end

    alias :purge! :purge_files
    alias :purge  :purge_files

  end

  extend CORE

end