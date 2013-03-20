# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# justdoc.rb
# ----------------------------------------------------------------------
# The main file which links the ruby gem.

require "justdoc/version"
require "justdoc/generator"
require "justdoc/output"
require "justdoc/reader"
require "justdoc/recognizer"
require "justdoc/outputs/markdown"

module Justdoc
  def self.setup(data: "")
    reader = Justdoc::Reader.new(data)
    r.read_and_recognize
  end
end
