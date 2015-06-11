#encoding: UTF-8
module TMP

  module ObjectExt

    def privatize opts= {}

      unless opts.class <= Hash
        raise ArgumentError,"invalid input for options"
      end

      %W[ e ex exc ].each do |str_sym|
        opts[:exclude] ||= opts[str_sym.to_sym]
      end

      %W[ i in inc only methods ].each do |str_sym|
        opts[:include] ||= opts[str_sym.to_sym]
      end

      %W[ t target ].each do |str_sym|
        opts[:target] ||= opts[str_sym.to_sym]
      end

      opts[:target] ||= 's'
      opts[:target]= opts[:target].to_s.downcase

      unless opts[:target][0] == "s" || opts[:target][0] == "i"
        %W[ singleton instance ].include?(opts[:target].to_s)
        raise ArgumentError, [
            "invalid options for target, you should use the following: ",
            "\n\tsingleton for targeting the singleton class what is de",
            "fault\n\tinstance for targeting the object instance methods."
        ].join
      end

      opts[:exclude] ||= []

      if opts[:target][0] == 'i' && self.class <= Module
        opts[:include] ||= self.instance_methods.map{|e| e.to_s }
      else
        opts[:target]= 's'
        opts[:include] ||= self.methods.map{|e| e.to_s }

      end

      [:include,:exclude].each do |array_name|

        unless opts[array_name].class <= Array
          opts[array_name]= [ opts[array_name] ]
        end

        opts[array_name].map!{ |element| ( element.class == String ? element : element.to_s ) }

      end

      opts[:exclude].push('__send__').push('object_id')

      if opts[:target][0] == 's'

        self.instance_eval do

          opts[:include].each do |sym|

            unless opts[:exclude].include?(sym)
              (class << self; self; end).__send__ :private, sym
            end

          end
        end

      elsif opts[:target][0] == 'i'

        opts[:include].each do |sym|

          unless opts[:exclude].include?(sym)
            self.__send__ :private, sym
          end

        end

      else
        STDERR.puts "invalid target definition"

      end


    end

  end


end