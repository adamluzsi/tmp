#encoding: UTF-8
module TMP

  module DSLCore

    def target_obj obj=nil

      @target_obj= obj unless obj.nil?
      @target_obj || ::TMP

    end

    def method_missing( method, *args, &block )

      if method.to_s.reverse[0] == '='

        target_obj.__send__ :write, method.to_s.reverse.sub('=','').reverse, args.first
        return args.first

      else

        unless block.nil?

          return target_obj.__send__ :block, method, *args, &block

        else

          if method =~ /^\w+__path__$/
            return target_obj.__send__ :path, method.to_s.sub!( /__path__$/,"" ),*args
          else
            return target_obj.__send__ :read, method
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

    def __tmp__
      ::TMP::DSL
    end

    alias :__TMP__  :__tmp__

  end

end

Object.__send__ :include, ::TMP::SyntaxSugar
