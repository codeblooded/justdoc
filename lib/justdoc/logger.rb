# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
module Justdoc
  class String
    def set_color(color)
        code = case color
        when :red then 31
        when :green then 32
        when :yellow then 33
        when :blue then 34
        when :magenta then 35
        when :cyan then 36
        "\e[#{code}m#{self}\e[0m"
      end
  end
  
  class Logger
    def initialize(enabled: false)
      @active = enabled
    end
    
    def enable
      @active = true if !@active
    end
    
    def disable
      @active = false if @active
    end
    
    def la(action: nil, text: nil, color: :green)
      if @active
        act = action.set_color(color)
        puts "=>\t#{act}:\t\t#{text}"
      end
    end
    
    def log(str, color = :white)
      console_log(str, color) if @active
    end
    
    def logn(str, color = :white)
      console_log(str+"\n", color) if @active
    end
    
    def console_log(str, color = :white)
      color == :white ? print(str) : print(str.set_color(color))
    end
  end
end
