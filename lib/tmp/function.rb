#encoding: UTF-8
module TMP

  module Support

    class << self

      def tmp_folder_path
        ::TMP::Config.folder_path
      end

      alias :folder_path :tmp_folder_path

      def tmp_folder_init

        begin

          Dir.mkdir tmp_folder_path
          return true

        rescue Errno::EEXIST
          return false
        end

      end

      def read_buffer path

        comm_line= File.open(path,"r")

        read_buffer = ::Thread.new do
          while !comm_line.eof?
            @value = ::Marshal.load( comm_line )
          end
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

      def purge_files!

        Dir.glob( File.join( tmp_folder_path,'**','*' ) ).each do |file_path|

          begin
            File.delete file_path
          rescue Errno::ENOENT
          end

        end

      end



    end
  end

  def self.write(*args)
    self::Support.write(*args)
  end

  def self.read(*args)
    self::Support.read(*args)
  end

  def self.purge!
    self::Support.purge_files!
  end


end