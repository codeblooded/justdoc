# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# generator.rb
# ----------------------------------------------------------------------
# A file generator that relies on the output mechanism for different 
# formats of documentation.
require 'forwardable'

module JustDoc
  class Generator < SimpleDelegator
    
    def generate_file(name: "untitled.txt", with: {})
      generate_file_content with
      
      File.open(".docs/#{name}", "w+") do |f|
        f.puts @content
      end
    end
    
    def generate_file_content(with)
      with[:modules].each do |mod|
        respond_to_module mod
      end
      
      with[:classes].each do |cla|
        respond_to_class cla
      end
      
      with[:properties].each do |pro|
        respond_to_property pro
      end
      
      with[:constructors].each do |con|
        respond_to_constructor con
      end
      
      with[:methods].each do |met|
        respond_to_method met
      end
      
      @content = end_of_file
    end
    
  end
end
