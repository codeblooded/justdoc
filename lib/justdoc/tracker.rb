# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
module Justdoc
  #! class: Tracker
  #  abstract: Tracks changes with Git
  #  description:
  #    The Tracker checks the repo and responds with files the documentation
  #    should update.
  #!!
  class Tracker
    
    def initialize
      # get and store the current and last commits
      @sha1 = Setup.last_commit?
    end
    
    def updated_files
      raw_updated = %x{ git diff --name-only HEAD #{@sha1}}
      # split on the \n delimiter
      files = raw_updated.split(/\n/)
    end
    
  end
end
