# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# recognizer.rb
# ----------------------------------------------------------------------
# The abstraction of recognizing the sytax of specific languages 
# and their commenting syntax.
module Justdoc
  class Recognizer
    #! method: c_recognize
    #  abstract: Recognizes C-based multiline comments
    #  params:
    #     x   =   The String to match
    #  description:
    #     A method that recognizes multiline C-based comments with an ! implying
    #     the use of Justdoc to document.
    #!!
    def c_recognize(x)
      /\/\*!([^*]|\r\n|(\/\*([^*]|\r\n)*\*\/))*\*\//.scan(x)
    end
  
    #! method: r_recognize
    #  abstract: Recognizes Ruby-based comments
    #  params:
    #     x   =   The String to match
    #  description:
    #     A method that recognizes hash style ruby-based comments with an ! 
    #     implying the use of Justdoc to document.
    #!!
    def r_recognize(x)
      /#!([^*]|\r\n|(#([^*])*))*#!!/.scan(x)
    end
  end
end