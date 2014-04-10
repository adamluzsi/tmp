#encoding: UTF-8
module TMP


  module DSLCore

    def target_obj obj=nil

      unless obj.nil?
        @target_obj= obj
      end

      @target_obj || ::TMP

    end

    def method_missing( method, *args, &block )

      @target_methods = [:write,:read,:file]

      if method.to_s.include?('=')
        target_obj.__send__ @target_methods[0], method.to_s.gsub('=',''), args.first
      else

        unless block.nil?

          if File.exist? File.join( target_obj.folder_path, method.to_s )
            args[0] ||= "r+"
          else
            args[0] ||= "w+"
          end

          File.open( File.join( target_obj.folder_path, method.to_s ), args[0] ,&block)

        else

          begin
            target_obj.__send__ @target_methods[1], method
          rescue TypeError
            File.open(File.join( target_obj.folder_path, method.to_s ),"r").read
          end

        end

      end

    end

  end

  module DSL

    extend ObjectExt
    extend DSLCore
    privatize

  end

  module SyntaxSugar

    def tmp
      ::TMP::DSL
    end

    alias :temporally :tmp

  end

end

Object.__send__ :include, ::TMP::SyntaxSugar