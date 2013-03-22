# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require 'rugged'

module Justdoc
  class Tracker
    
    def initialize
      # initialize with Rugged discovering the git repo
      @repo = Rugged::Repository.discover(Dir.pwd)
    end
    
    def staged_files
      ind = Rugged::Index.new()
    end
    
  end
end
