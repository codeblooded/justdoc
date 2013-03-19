# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# output.rb
# ----------------------------------------------------------------------
# An abstraction of the output specification for generated documentation.

module JustDoc
  class OutputSpecification
    
    def respond_to_module
      raise NOTIMPLEMENTEDERROR
    end
    
    def respond_to_class
      raise NOTIMPLEMENTEDERROR
    end
    
    def respond_to_method
      raise NOTIMPLEMENTEDERROR
    end
    
    def respond_to_property
      raise NOTIMPLEMENTEDERROR
    end
    
  end
end
