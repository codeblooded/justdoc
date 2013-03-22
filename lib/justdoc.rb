# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# justdoc.rb
# ----------------------------------------------------------------------
# The main file which links the ruby gem.

require "justdoc/version"
require "justdoc/tracker"
require "justdoc/generator"
require "justdoc/reader"
require "justdoc/recognizer"
require "justdoc/outputs/markdown"

module Justdoc
  def run_with_git
    Setup.create_directory_and_config
    Setup.add_to_gitignore
  end
  
  def run_with_file(data)
    data = File.expand_path(data, Dir.pwd)
    reader = Justdoc::Reader.new(data)
    reader.read_and_recognize
    reader.document_to_generator
  end
end
