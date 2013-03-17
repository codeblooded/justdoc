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
      @file         = file
      @recognizer   = Justdoc::Recognizer.new
      @documents    = {modules: [], classes: [], constructors: [], 
        methods: [], properties: []}
      @current_read = ""
      @language     = ""
    end
    
    #! method: read_and_recognize
    #  abstract: Read from the file and Let the Recognizer parse
    #  description:
    #     A method to read from the file specified in the constructor.
    #     It uses the instantiated Justdoc::Recognizer to parse the
    #     file for documentation.  Finally, it sorts into the varies
    #     arrays and hashes that make up the documents.
    #!!
    def read_and_recognize
      f    = File.read(@file)
      code = @recognizer.detect_source
      @comment_syntax == :rbased ? @recognizer.r_recognize(f) : @recognizer.c_recognize(f)
    end
    
    #! method: detect_source
    #  abstract: Detects the language of a file.
    #  description:
    #     Detects the language comment syntax based on file extension.
    #!!
    def detect_source
      @comment_syntax = case @file
          when @file.include? ".rb"  then :rbased
          when @file.include? ".c"   then :cbased
          when @file.include? ".cs"  then :cbased
          when @file.include? ".m"   then :cbased
          when @file.include? ".cpp" then :cbased
          when @file.include? ".h"   then :cbased
      end
    end
    
  end
end
