#encoding: UTF-8
module TMP
  module Config
    class << self

      def default_folder_path
        File.join( Dir.tmpdir, ( Dir.pwd.split(File::Separator).last.to_s  ) )
      end

      @@config_path= nil
      def folder_path path= nil

        unless path.nil?

          unless path.class <= String
            raise ArgumentError,"invalid path class"
          end

          @@config_path = File.absolute_path(path)

        end

        @@config_path || default_folder_path

      end

    end
  end

  def self.folder_path obj
    self::Config.folder_path(obj)
  end

end
