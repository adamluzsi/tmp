#encoding: UTF-8
module TMP

  module CORE

    def project_name name_string= nil

      unless name_string.nil?

        unless name_string.class <= String
          raise ArgumentError,"invalid name string"
        end

        @project_name = name_string

      end

      @project_name || Dir.pwd.split(File::Separator).last.to_s

    end

    alias :project_folder :project_name

    def tmpdir
      ::Dir.tmpdir
    end

    def default_folder_path
      File.join( tmpdir , project_name )
    end

    @folder_path= nil
    def tmp_folder_path path_string= nil

      unless path_string.nil?

        unless path_string.class <= String
          raise ArgumentError,"invalid path class, must be string like"
        end

        @folder_path = File.absolute_path(path_string)

      end

      @folder_path || default_folder_path

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

    alias :folder_init :tmp_folder_init

    def write variable_name, data_object

      tmp_folder_init

      File.open( File.join(tmp_folder_path,variable_name.to_s) ,"w") do |file|
        return file.write ::Marshal.dump(data_object)
      end

    end

    def block variable_name, *args, &block_obj

      tmp_folder_init

      options = args.select{|e|(e.class <= ::Hash)}.reduce({},:merge!)
      args.select!{|e|!(e.class <= ::Hash)}

      options[:file_extension] ||= options[:extension] || options[:ext]
      file_name = variable_name.to_s
      options[:file_mod] ||= options[:mod] || args[0].class <= ::String ? args[0] : nil

      unless options[:file_extension].nil?

        while options[:file_extension][0] == '.'
          options[:file_extension][0]= ''
        end

        file_name += ".#{options[:file_extension]}"

      end

      if File.exist?(File.join( tmp_folder_path, file_name ))
        options[:file_mod] ||= "r+"
      else
        options[:file_mod] ||= "w+"
      end

      begin
        return File.open( File.join( tmp_folder_path, file_name ), options[:file_mod], &block_obj )
      rescue Errno::ENOENT
        var_file= File.new( File.join( tmp_folder_path, file_name ), options[:file_mod])
        block_obj.call(var_file) unless block_obj.nil?
        var_file.close
      end

    end

    def read variable_name

      unless File.exist?(File.join( tmp_folder_path,variable_name.to_s))
        return nil
      end

      File.open( File.join( tmp_folder_path,variable_name.to_s ) ,"r+") do |file|

        var= file.read
        begin
          return ::Marshal.load var
        rescue
          return var
        end

      end

    end

    def path variable_name,*args

      options = args.select{|e|(e.class <= ::Hash)}.reduce({},:merge!)
      args.select!{|e|!(e.class <= ::Hash)}

      variable_name = variable_name.to_s
      options[:file_extension] ||= options[:extension] || options[:ext]
      unless options[:file_extension].nil?
        while options[:file_extension][0] == '.'
          options[:file_extension][0]= ''
        end
        variable_name += ".#{options[:file_extension]}"
      end

      tmp_folder_init
      path_to_file= File.join( tmp_folder_path, variable_name )
      unless File.exist?(path_to_file)
        File.open( path_to_file ,"w") {|f| f.write(""); f.close }
      end
      return path_to_file

    end

    def purge_files

      Dir.glob( File.join( tmp_folder_path,'**','*' ) ).map do |file_path|

        begin
          File.delete file_path
        rescue Errno::ENOENT => ex
          ex
        end

      end

    end

    alias :purge! :purge_files
    alias :purge  :purge_files

  end

  extend CORE

end