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
      @sha2 = Setup.last_commit?
      @sha1 = current_commit
    end
    
    def current_commit
      %x{ git rev-parse HEAD }.chomp
    end
    
    def updated_files
      # get the files that have changed
      cmmd = "git diff --name-only #{@sha1} #{@sha2}"
      raw_updated = %x{ #{cmmd} }
      # split on the \n delimiter
      files = raw_updated.split(/\n/)
    end
    
  end
end
