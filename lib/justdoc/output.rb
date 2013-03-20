# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# output.rb
# ----------------------------------------------------------------------
# An abstraction of the output specification for generated documentation.

module JustDoc
  class OutputSpecification
    
    def respond_to_module(data)
      raise NOTIMPLEMENTEDERROR
    end
    
    def respond_to_class(data)
      raise NOTIMPLEMENTEDERROR
    end
    
    def respond_to_method(data)
      raise NOTIMPLEMENTEDERROR
    end
    
    def respond_to_property(data)
      raise NOTIMPLEMENTEDERROR
    end
    
    def end_of_file
      raise NOTIMPLEMENTEDERROR
    end
    
  end
end
