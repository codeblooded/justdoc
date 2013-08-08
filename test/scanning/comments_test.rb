# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require "minitest_helper"

describe Justdoc::Recognizer do
  
  it 'finds a c-style comment in a string' do
    comment = "/*! is this found */"
    rec = Justdoc::Recognizer.new()
    match = rec.recognize(comment, :cstyle)
    match.wont_be_empty
  end
  
  it 'finds multiple c-style comments in a string' do
    comments = "/*! comment one */ int main(); /*! comment two */"
    rec = Justdoc::Recognizer.new()
    matches = rec.recognize(comments, :cstyle)
    matches.length().must_equal 2
  end
  
  it 'does not count nested c-style comments in a string' do
    comments = "/*! main comment int main(); /* nested comment */ */"
    rec = Justdoc::Recognizer.new()
    matches = rec.recognize(comments, :cstyle)
    matches.length().must_equal 1
  end
  
  it 'detects a c-style comment across multiple lines' do
    comment = "/*! first part \n continued \n second part */"
    rec = Justdoc::Recognizer.new()
    match = rec.recognize(comment, :cstyle)
    match.wont_be_empty
  end
  
  it 'finds a r-style comment in a string' do
    comment = "#! my comment of documentation #!!"
    rec = Justdoc::Recognizer.new()
    match = rec.recognize(comment, :rstyle)
    match.wont_be_empty
  end
  
  it 'finds multiple r-style comments in a string' do
      comments = "#! comment one #!! class here; end #! comment two #!!"
      rec = Justdoc::Recognizer.new()
      match = rec.recognize(comments, :rstyle)
      match.length().must_equal 2
  end
  
  it 'ignores nested r-style comments in a string' do
    comments = "#! main comment class rbhere; end # comment two #!!"
    rec = Justdoc::Recognizer.new()
    match = rec.recognize(comments, :rstyle)
    match.length().must_equal 1
  end
  
  it 'detects a r-style comment across multiple lines' do
    comment = "#! first part
    # continued second part
    #!!"
    rec = Justdoc::Recognizer.new()
    match = rec.recognize(comment, :rstyle)
    match.wont_be_empty
  end
  
  it 'should detect and match rstyle comments' do
    comment = "#! class: Recognizer
    #  abstract: Recognizes Documentation in Comments 
    #  description:
    #    The abstraction of recognizing documentation in files.
    #!!"
    rec = Justdoc::Recognizer.new()
    match = rec.recognize(comment, :rstyle)
    matches = rec.scan_matches
    matches.wont_be_nil
  end
  
  it 'should detect and match abstract sections in cstyle comments' do
    comment = "/*! class: Here 
    abstract: abstracted
    description:
        long description
    */"
    rec = Justdoc::Recognizer.new()
    rec.recognize(comment, :cstyle)
    matches = rec.scan_matches
    matches[:classes][0][:abstract].must_equal "abstracted"
  end
  
  it 'should detect and match description sections in cstyle comments' do
    comment = "/*! class: Here 
    abstract: abstracted
    description:
        long description
    */"
    rec = Justdoc::Recognizer.new()
    rec.recognize(comment, :cstyle)
    matches = rec.scan_matches
    matches[:classes][0][:description].must_equal "long description"
  end
  
  
  it 'should detect and match abstract sections in rstyle comments' do
    comment = "#! class: Recognizer
    #  abstract: Recognizes Documentation in Comments
    #  description:
    #     The abstraction of recognizing documentation in files.
    #!!"
    rec = Justdoc::Recognizer.new()
    match = rec.recognize(comment, :rstyle)
    matches = rec.scan_matches
    matches[:classes][0][:abstract].must_equal "Recognizes Documentation in Comments"
  end
  
  it 'should detect and match description sections in rstyle comments' do
    comment = "#! class: Here 
    # abstract: abstracted
    # description:
        long description
    #!!"
    rec = Justdoc::Recognizer.new()
    rec.recognize(comment, :rstyle)
    matches = rec.scan_matches
    matches[:classes][0][:description].must_equal "long-description"
  end
  
end
