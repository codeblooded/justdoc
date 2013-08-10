# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require "minitest_helper"

describe Justdoc::Recognizer do
  
  it 'should recognize a class' do
    input = "#! class: Human
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
    documents[:classes].wont_be_empty
  end
  
  it 'should recognize abstract section of a class' do
    input = "#! class: Human
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
    results = documents[:classes]
    results[0][:abstract].must_equal "Defines Characteristics and Methods of a Human."
  end
  
  it 'should recognize description of a class' do
    input = "#! class: Human
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
    results = documents[:classes]
    results[0][:description].must_equal "The human class inherits methods from the Animal class. It allows methods to be called on a human object."
  end
  
  it 'should recognize the full name of a class with a nested colon' do
    input = "#! class: Hu:man
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
    documents[:classes][0][:name].must_equal "Hu:man"
  end
  
  it 'should recognize the full name of a class with a trailing colon' do
    input = "#! class: Human:
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
    documents[:classes][0][:name].must_equal "Human:"
  end
  
end
