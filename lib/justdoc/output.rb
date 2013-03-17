# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# output.rb
# ----------------------------------------------------------------------
# An abstraction of the output specification for generated documentation.

module JustDoc
  class OutputSpecification
    
    attr_accessor :name, :author, :files
    
    def initialize
      @dependencies = []
      yield self
    end
    
    def add_dependency(x, version)
      @dependencies << {gem_name: x, version: version}
    end
  end
end
