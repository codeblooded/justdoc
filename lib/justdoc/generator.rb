# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# generator.rb
# ----------------------------------------------------------------------
# A file generator that relies on the output mechanism for different 
# formats of documentation.

module JustDoc
  class Generator
    
    def initialize(documents)
      @documents = documents
    end
    
    def write_or_update(&writes)
      File.open(@filename, 'w+') do |f|
        writes.call(f)
      end
    end
    
    private
    
      def prepare_output(format)
        
      end
    
  end
end
