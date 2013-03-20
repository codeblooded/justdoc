# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require "minitest_helper"

describe Justdoc::Recognizer do
  
  it 'should recognize a constructor - cstyle' do
    input = "/*! constructs: Device
    abstract: Constructor for device */"
    r = Justdoc::Recognizer.new
    r.recognize(input, :cstyle)
    documents = r.scan_matches
    documents[:constructors][0][:name].must_equal "Device"
  end
  
  it 'should recognize a constructor - rstyle' do
    input = "#! constructs: Device
    # abstract: Constructor for device
    #!!"
    r = Justdoc::Recognizer.new
    r.recognize(input, :rstyle)
    documents = r.scan_matches
    documents[:constructors][0][:name].must_equal "Device"
  end

  it 'should recognize multiple parameters in a constructor - cstyle' do
    input = "/*! constructs: Rocket 
    params:
        astronaut   =   The astronaut to pilot
        speed       =   The speed of the rocket
    */"
    r = Justdoc::Recognizer.new
    r.recognize(input, :cstyle)
    documents = r.scan_matches
    documents[:constructors][0][:params][0][:key].must_equal "astronaut"
    documents[:constructors][0][:params][0][:value].must_equal "The astronaut to pilot"
    documents[:constructors][0][:params][1][:key].must_equal "speed"
    documents[:constructors][0][:params][1][:value].must_equal "The speed of the rocket"
  end
  
  it 'should recognize multiple parameters in a constructor - rstyle' do
    input = "#! constructs: Rocket 
    # params:
    #   astronaut   =   The astronaut to pilot
    #   speed       =   The speed of the rocket
    #!!"
    r = Justdoc::Recognizer.new
    r.recognize(input, :rstyle)
    documents = r.scan_matches
    documents[:constructors][0][:params][0][:key].must_equal "astronaut"
    documents[:constructors][0][:params][0][:value].must_equal "The astronaut to pilot"
    documents[:constructors][0][:params][1][:key].must_equal "speed"
    documents[:constructors][0][:params][1][:value].must_equal "The speed of the rocket"
  end
  
end
