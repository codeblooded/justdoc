# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require "minitest_helper"

describe Justdoc::Recognizer do

  it 'should recognize modules - rstyle' do
    input = "#! module: Human
      #!
      #! abstract: Defines Characteristics and Methods of a Human.
      #!
      #! description:
      #!    The human class inherits methods from the Animal class.
      #!    It allows methods to be called on a human object.
      #!!"
    rec = Justdoc::Recognizer.new
    rec.recognize(input, :rstyle)
    documents = rec.scan_matches
    documents[:modules][0][:name].must_equal "Human"
  end
  
  it 'should recognize modules - cstyle' do
    input = "/*! module: Human
      abstract: Defines Characteristics and Methods of a Human.
      description:
          The human class inherits methods from the Animal class.
          It allows methods to be called on a human object.
      */"
    rec = Justdoc::Recognizer.new
    rec.recognize(input, :cstyle)
    documents = rec.scan_matches
    documents[:modules][0][:name].must_equal "Human"
  end

end
