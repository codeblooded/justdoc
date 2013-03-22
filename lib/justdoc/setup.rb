# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require 'rugged'
require 'yaml'

module Justdoc
  class Setup
    
    def self.create_directory_and_config
      
      base = {version: Justdoc::VERSION, created_at: Time.now}
      Dir.mkdir(".docs")
      $vl.la action: "create" text: ".docs/"
      File.open(".docs/.justdoc.yml", "w+") do |f|
        f.write(base.to_yaml)
      end
      $vl.la action: "create" text: ".docs/justdoc.yml"
    end
    
    def self.add_to_gitignore
      File.open(".gitignore", "a") do |f|
        f.puts ".docs/*"
      end
    end
    
  end
end
