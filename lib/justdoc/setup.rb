# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require 'rugged'
require 'yaml'

module Justdoc
  class Setup
    
    def self.ask_questions
      # prompt for values
      STDOUT.puts "> Please respond to the following questions to setup documentation."
      STDOUT.print "  Project Name: "
      repo_name = STDIN.gets.chomp
      STDOUT.print "  Developer: "
      repo_author = STDIN.gets.chomp
      STDOUT.print "  Track Changes with Git [Y/n]? "
      use_git = (STDIN.gets.chomp == "n") ? false : true       
      if use_git
         STDOUT.print "  Add Docs to .gitignore [Y/n]? "
         ignore_docs = (STDIN.gets.chomp == "n") ? false : true
         STDOUT.print "  Archive Versions of Docs with Git Tags [Y/n]? "
         archive_docs = (STDIN.gets.chomp == "n") ? false : true
         # get and store sha1
         git = {sha1: %x{ git rev-parse HEAD }.chomp}
      end
      @@base = {justdoc_version: Justdoc::VERSION, created_at: Time.now, project_name: repo_name, project_developer: repo_author, git_enabled: use_git, git_ignore: ignore_docs, archive_docs: archive_docs}
      use_git ? @@base = @@base.merge(git) : @@base
    end
    
    def self.create_directory_and_config
      # create the necessary directories and write the original hash to the config file
      Dir.mkdir(".docs")
      File.open(".docs/.justdoc.yml", "w+") do |f|
        f.write(@@base.to_yaml)
      end
    end
    
    def self.add_to_gitignore
      # if the user said to ignore documentation, add to .gitignore file
      if @@base[:git_ignore]
        File.open(".gitignore", "a") do |f|
          f.puts "\.docs/*"
        end
      end
    end
    
    def self.configured?
      # check if the configuration file exists
      File.exists?("./.docs/.justdoc.yml") ? true : false
    end
    
    def self.configuration
      # load the configuration file
      $cf = YAML.load_file('./.docs/.justdoc.yml')
    end
    
    def self.last_commit?
      # if the config hash has not been loaded, load it
      configuration if $cf.nil?
      # return sha-1
      $cf[:sha1]
    end
    
    def self.update_with_commit(id)
      $cf[:sha1] = id
      File.open(".docs/.justdoc.yml", "w+") do |f|
        f.write($cf.to_yaml)
      end
    end
  end
end
