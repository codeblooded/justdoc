# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require 'rugged'
require 'yaml'

module Justdoc
  class Setup
    
    def self.ask_questions
       STDOUT.print "Project Name: "
       repo_name = STDIN.gets.chomp
       STDOUT.print "Developer: "
       repo_author = STDIN.gets.chomp
       STDOUT.print "Track Changes with GIT [Y/n]? "
       use_git = (STDIN.gets.chomp == "n") ? false : true       
       STDOUT.print "Archive all Versions of Docs [Y/n]? "
       archive_docs = (STDIN.gets.chomp == "n") ? false : true
       if use_git
         STDOUT.print "Add Docs to .gitignore [Y/n]? "
         ignore_docs = (STDIN.gets.chomp == "n") ? false : true
       end
       @@base = {justdoc_version: Justdoc::VERSION, created_at: Time.now, project_name: repo_name, project_developer: repo_author, git_enabled: use_git, git_ignore: ignore_docs, archive_docs: archive_docs}
    end
    
    def self.create_directory_and_config
      Dir.mkdir(".docs")
      File.open(".docs/.justdoc.yml", "w+") do |f|
        f.write(@@base.to_yaml)
      end
    end
    
    def self.add_to_gitignore
      File.open(".gitignore", "a") do |f|
        f.puts ".docs/*"
      end
    end
    
    def self.configured?
      File.exists?("./.docs/.justdoc.yml") ? true : false
    end
    
  end
end
