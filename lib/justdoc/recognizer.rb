# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# recognizer.rb
# ----------------------------------------------------------------------
# The abstraction of recognizing the sytax of specific languages 
# and their commenting syntax.

class Recognizer
  
  def c_recognize(x)
    /\/\*!([^*]|\r\n|(\/\*([^*]|\r\n)*\*\/))*\*\//.match(x)
  end
  
  def r_recognize(x)
    /#!.*\n/.match(x)
  end
  
  def is_cbased?
    false
  end
  
end