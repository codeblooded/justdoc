# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# reader.rb
# ----------------------------------------------------------------------
# The class responsible for reading each ruby file and using an instance
# of the Justdoc::Recognizer to recognize documentation.
module Justdoc
  class Reader
  
    #! constructs: Reader
    #  abstract: Constructs a new Reader
    #  params:
    #     file   =   The name of the file to read
    #  description:
    #     A constructor for the Justdoc::Reader.
    #!!
    def initialize(file)
      @file       = file
      @recognizer = Justdoc::Recognizer.new
      @documents  = {modules: [], classes: [], constructors: [], methods: [], properties: []}
    end
    
    def read_and_recognize
      counter = 1
      File.open("@file", "r") do |line|
        while line.gets
          puts"#{counter}: #{line}"
          counter = counter + 1
        end
    end
    
  end
end
