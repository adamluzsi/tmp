#encoding: UTF-8
module TMP

  module DSLCore

    def method_missing( method, *args )
      @class_name ||= ::TMP

      if method.to_s.include?('=')
        @class_name.write( method.to_s.gsub('=',''), args.first )
      else
        @class_name.read( method )
      end

    end

  end

  class DSL < ::EmptyObject
    extend DSLCore
  end

  module SyntaxSugar

    def tmp
      ::TMP::DSL
    end

  end

end

Object.__send__ :include, ::TMP::SyntaxSugar