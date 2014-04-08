#encoding: UTF-8
module TMP

  class DSL < ::EmptyObject
    class << self
      def method_missing(method, *args)

        if method.to_s.include?('=')
          ::TMP.write method.to_s.gsub('=',''), args.first
        else
          ::TMP.read(method)
        end

      end
    end
  end

  module SyntaxSugar

    def tmp
      ::TMP::DSL
    end

  end

end

Object.__send__ :include, ::TMP::SyntaxSugar