# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
require 'rugged'
require 'yaml'

module Justdoc
  class Setup
    class << self
    def create_directory_and_config
      base = {version: Justdoc::VERSION, created_at: Time.now.utc}
      Dir.mkdir(".docs")
      File.open(".docs/.justdoc.yml", "w+") do |f|
        f.write(base.to_yaml)
      end
    end
    
    def add_to_gitignore
      File.open(".gitignore", "a") do |f|
        f.puts ".docs/*"
      end
    end
  end
end
