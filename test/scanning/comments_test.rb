require "minitest_helper"

describe Justdoc::Recognizer do
  
  it "finds a c-style comment in a string" do
    comment = "/*! is this found */"
    match   = Justdoc::Recognizer.new().c_recognize(comment)
    match.wont_be_empty
  end
  
  it "finds multiple c-style comments in a string" do
    comments = "/*! comment one */ int main(); /*! comment two */"
    matches  = Justdoc::Recognizer.new().c_recognize(comments)
    matches.length().must_equal 2
  end
  
  it "does not count nested c-style comments in a string" do
    comments = "/*! main comment int main(); /* nested comment */ */"
    matches  = Justdoc::Recognizer.new().c_recognize(comments)
    matches.length().must_equal 1
  end
  
  it "detects a c-style comment across multiple lines" do
    comment = "/*! first part \n continued \n second part */"
    match   = Justdoc::Recognizer.new().c_recognize(comment)
    match.wont_be_empty
  end
  
  it "finds a r-style comment in a string" do
    comment = "#! my comment of documentation #!!"
    match   = Justdoc::Recognizer.new().r_recognize(comment)
    match.wont_be_empty
  end
  
  it "finds multiple r-style comments in a string" do
      comments = "#! comment one #!! class here; end #! comment two #!!"
      match    = Justdoc::Recognizer.new().r_recognize(comments)
      match.length().must_equal 2
  end
  
  it "ignores nested r-style comments in a string" do
    comments = "#! main comment class rbhere; end # comment two #!!"
    match  = Justdoc::Recognizer.new().r_recognize(comments)
    match.length().must_equal 1
  end
  
  it "detects a r-style comment across multiple lines" do
    comment = "#! first part \n # continued second part \n #!!"
    match   = Justdoc::Recognizer.new().r_recognize(comment)
    match.wont_be_empty
  end
  
end
