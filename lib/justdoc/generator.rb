# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# generator.rb
# ----------------------------------------------------------------------
# A file generator that relies on the output mechanism for different 
# formats of documentation.
module Justdoc
  class Generator
    
    def initialize(gen)
      @gen = gen
    end
    
    def generate_file(name: "untitled.txt", with: {})
      generate_file_content with
      
      File.open(".docs/#{name}", "w+") do |f|
        f.puts @content
      end
    end
    
    def generate_file_content(with)
      with[:modules].each do |mod|
        @gen.respond_to_module mod
      end
      
      with[:classes].each do |cla|
        @gen.respond_to_class cla
      end
      
      with[:properties].each do |pro|
        @gen.respond_to_property pro
      end
      
      with[:constructors].each do |con|
        @gen.respond_to_constructor con
      end
      
      with[:methods].each do |met|
        @gen.respond_to_method met
      end
      
      @content = @gen.end_of_file
    end
    
  end
end
