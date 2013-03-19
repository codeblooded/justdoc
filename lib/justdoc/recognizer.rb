# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# recognizer.rb
# -----------------------------------------------------------------------
# The abstraction of recognizing the sytax of specific languages 
# and their commenting syntax.
require 'debugger'

module Justdoc
  class Recognizer
    
    attr_accessor :style
    
    #! constructs: Recognizer
    #!!
    def initialize
      @documents = {modules: [], classes: [], constructors: [], 
        methods: [], properties: []}
    end
  
    #! method: recognize
    #  abstract: Recognizes documentation in comments
    #  params:
    #     x   =   The String to match
    #  description:
    #     A method that recognizes comments with an ! 
    #     implying the use of Justdoc to document.
    #!!
    def recognize(x, style)
      if (style == :cstyle)
        @matches = enum_scan(x, /\/\*!([^*]|\r\n|(\/\*([^*]|\r\n)*\*\/))*\*\//)
      else
        @matches = enum_scan(x, /#!([^*]|\r\n|(#([^*])*))*?#!!/)
      end
    end
    
    def scan_matches
      @matches.each { |match| find_type_and_document(match.to_s) }
      # debugger
      @documents
    end
    
    def documents
      @documents
    end
    
    private
    
      def enum_scan(str, pattern)
        matches = []
        raw_matches = str.to_enum(:scan, pattern).map { Regexp.last_match }
        raw_matches.each do |match|
          matches << match[0].to_s
        end
        matches
      end
    
      def find_type_and_document(match)
        if match.include? "module:"
          scan_module(match)
        elsif match.include? "class:"
          scan_class(match)
        elsif match.include? "method:"
          scan_method(match)
        elsif match.include? "var:"
          scan_property(match)
        else
          raise match.to_s
        end
      end
    
    
      def scan_module(str)
        module_name = /module:\s*(.*)\n/.match(str)
        @documents[:modules] << {name: module_name, 
          abstract: get_abstract(str), description: get_description(str)}
      end
    
      def scan_class(str)
        class_name = /class:\s*(.*)\n/.match(str)
        @documents[:classes] << {name: class_name, 
          abstract: get_abstract(str), description: get_description(str)}
      end
    
      def scan_method(str)
        method_name = /method:\s*(.*)\n/.match(str)
        @documents[:methods] << {name: method_name, 
          abstract: get_abstract(str), description: get_description(str), 
          params: get_params(str)}
      end
    
      def scan_property(str)
        property_name = match_and_normalize text: str, pattern: /var:\s*(.*)\n/
        @documents[:properties] << {name: property_name, 
          abstract: get_abstract(str), description: get_description(str), 
          type: get_type(str)}
      end
    
      def get_abstract(str)
        if (str.include? "abstract:")
          match_and_normalize text: str, pattern: /abstract:(\s+(.*)\n)/
          # res = /abstract:(\s+(.*)\n)/.match(str)
          #           res = res[0].gsub(/abstract:\s+/, "") if !res.nil?
          #           title = res.split(/\s*:\s*/)
          #           title[1]
        end
      end
      
      def get_description(str)
        if (str.include? "description:")
          match_and_normalize text: str, pattern: /description:\n((#|\*)*\s+(.*)\n)*/
          # res = /description:\n((#|\*)*\s+(.*)\n)*/.match(str)
          #           res = res.gsub(/description:\n/, "") if !res.nil?
          #           title = res.split(/\s*:\s*/)
          #           title[1]
        end
      end
      
      def get_params(str)
        params = []
        res = /params:\n((#|\*)*\s+(.*)=(.*)\n)*/.match(str)
        res = res.gsub(/params:\n/, "")
        matches = res.scan(/(.*)=(.*)\n/)
        matches.each do |m1|
         m2 = m1.strip
         pair = m2.split(/\s*=\s*/)
         params << {key: pair[0], value: pair[1]}
        end
        params
      end
      
      def get_type(str)
        match_and_normalize text: str, pattern: /type:\s*(.*)\n/
        # res = /type:\s*(.*)\n/.match(str)
        #         res = res[0].strip
        #         title = res.split(/\s*:\s*/)
        #         title[1]
      end
      
      def match_and_normalize(text: nil, pattern: //, delimiter: /\s*:\s*/)
        ret = nil
        res = pattern.match(text)
        if !res.nil?
          results = res.to_a
          results[0].gsub(pattern, "")
          title = results[0].split(delimiter)
          ret = title[1].strip
        end
        ret
      end
    
  end
end