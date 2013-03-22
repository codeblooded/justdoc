# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# justdoc.rb
# ----------------------------------------------------------------------
# The main file which links the ruby gem.

require "justdoc/version"
require "justdoc/tracker"
require "justdoc/setup"
require "justdoc/generator"
require "justdoc/reader"
require "justdoc/recognizer"
require "justdoc/outputs/markdown"

module Justdoc
  
  def self.run_setup
    Setup.create_directory_and_config
    Setup.add_to_gitignore
  end
  
  def self.run_with_git
    if Setup.configured?
      track = Tracker.new
      updoc = track.updated_files
      updoc.each do |file|
        run_with_file(file)
      end
    else
      "Repo not configured, please run `justdoc setup`..."
    end
  end
  
  def self.run_with_file(data)
    data = File.expand_path(data, Dir.pwd)
    reader = Justdoc::Reader.new(data)
    reader.read_and_recognize
    reader.document_to_generator
  end
  
end
