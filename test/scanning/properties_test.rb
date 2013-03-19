# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require "minitest_helper"

describe Justdoc::Recognizer do
  
  it 'should recognize a property' do
    input = "#! var: height \n #! type: integer \n #!!"
    r     = Justdoc::Recognizer.new
    r.recognize(input, :rstyle)
    r.scan_matches
    results = r.documents[:properties]
    results.wont_be_empty
  end
  
  it 'should divide a property properly' do
    input = "#! var: weight \n #! type: string
    #! abstract: The weight of the human. \n #! \n #! description: 
    #!    Get/Set the weight of the human. \n #!!"
    r     = Justdoc::Recognizer.new
    r.recognize(input, :rstyle)
    expected = {name: 'weight', type: 'string', abstract: 'The weight of the human.', description: 'Get/Set the weight of the human.'}
    documents = r.scan_matches
    documents[:properties][0][:name].must_equal expected[:name]
  end
  
  it 'should recognize type of a property' do
    input = "#! var: height \n #! type: integer \n #!!"
    r     = Justdoc::Recognizer.new
    r.recognize(input, :rstyle)
    documents = r.scan_matches
    documents[:properties][0][:type].must_equal "integer"
  end

end
