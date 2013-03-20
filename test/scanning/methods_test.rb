# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require "minitest_helper"

describe Justdoc::Recognizer do

  it 'should recognize a method - cstyle' do
    input = "/*! method: goToTheMoon()
    abstract: sends to the moon */"
    r = Justdoc::Recognizer.new
    r.recognize(input, :cstyle)
    documents = r.scan_matches
    documents[:methods][0][:name].must_equal "goToTheMoon()"
  end
  
  it 'should recognize a parameter in a method - cstyle' do
    input = "/*! method: goToTheMoon(astronaut)
    abstract: sends to the moon 
    params:
        astronaut   =   The astronaut to send
    */"
    r = Justdoc::Recognizer.new
    r.recognize(input, :cstyle)
    documents = r.scan_matches
    documents[:methods][0][:params][0][:key].must_equal "astronaut"
    documents[:methods][0][:params][0][:value].must_equal "The astronaut to send"
  end
  
  it 'should recognize multiple parameters in a method - cstyle' do
    input = "/*! method: goToTheMoon(astronaut, speed)
    abstract: sends to the moon 
    params:
        astronaut   =   The astronaut to send
        speed       =   The speed of the rocket
    */"
    r = Justdoc::Recognizer.new
    r.recognize(input, :cstyle)
    documents = r.scan_matches
    documents[:methods][0][:params][0][:key].must_equal "astronaut"
    documents[:methods][0][:params][0][:value].must_equal "The astronaut to send"
    documents[:methods][0][:params][1][:key].must_equal "speed"
    documents[:methods][0][:params][1][:value].must_equal "The speed of the rocket"
  end
  
  it 'should recognize a method - rstyle' do
    input = "#! method: go_to_the_moon
    # abstract: sends to the moon
    #!!"
    r = Justdoc::Recognizer.new
    r.recognize(input, :rstyle)
    documents = r.scan_matches
    documents[:methods][0][:name].must_equal "go_to_the_moon"
  end
  
  it 'should recognize a parameter in a method - rstyle' do
    input = "#! method: go_to_the_moon(astronaut)
    # abstract: sends to the moon 
    # params:
    #   astronaut   =   The astronaut to send
    #!!"
    r = Justdoc::Recognizer.new
    r.recognize(input, :rstyle)
    documents = r.scan_matches
    documents[:methods][0][:params][0][:key].must_equal "astronaut"
    documents[:methods][0][:params][0][:value].must_equal "The astronaut to send"
  end
  
  it 'should recognize multiple parameters in a method - rstyle' do
    input = "#! method: goToTheMoon(astronaut, speed)
    # abstract: sends to the moon 
    # params:
    #   astronaut   =   The astronaut to send
    #   speed       =   The speed of the rocket
    #!!"
    r = Justdoc::Recognizer.new
    r.recognize(input, :rstyle)
    documents = r.scan_matches
    documents[:methods][0][:params][0][:key].must_equal "astronaut"
    documents[:methods][0][:params][0][:value].must_equal "The astronaut to send"
    documents[:methods][0][:params][1][:key].must_equal "speed"
    documents[:methods][0][:params][1][:value].must_equal "The speed of the rocket"
  end
  
end
