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
    #     x       =   The String to match
    #     style   =   The Style of Comments (C-Style or Ruby-Style)
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
    
    #! method: scan_matches
    #  abstract: Passes each match to be ordered and documented.
    #  description:
    #     scan_matches iterates over each match and passes the
    #     match to find_type_and_document, a private method in
    #     the Recognizer class.  It relies on the @matches
    #     instance variable to be set.
    #  returns: The ordered documents
    #!!
    def scan_matches
      @matches.each { |match| find_type_and_document(match.to_s) }
      # debugger
      @documents
    end
    
    #! method: documents
    #  description:
    #     A method used primarily for testing purposes. (DEPRECATED)
    #  returns: The ordered documents
    #!!
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
    
      #! method: find_type_and_document
      #  abstract: Finds type and documents
      #  params:
      #    match = The string to accept
      #  description:
      #    Finds the type of document and directs to appropriate method.
      #!!
      def find_type_and_document(match)
        if match.include? "module:"
          scan_module(match)
        elsif match.include? "class:"
          scan_class(match)
        elsif match.include? "method:"
          scan_method(match)
        elsif match.include? "var:"
          scan_property(match)
        end
      end
    
    
      def scan_module(str)
        module_name = match_and_normalize text: str, pattern: /module:\s*(.*)\n/
        @documents[:modules] << {name: module_name, 
          abstract: get_abstract(str), description: get_description(str)}
      end
    
      def scan_class(str)
        class_name = match_and_normalize text: str, pattern: /class:\s*(.*)\n/
        @documents[:classes] << {name: class_name, 
          abstract: get_abstract(str), description: get_description(str)}
      end
    
      def scan_method(str)
        method_name = match_and_normalize text: str, pattern: /method:\s*(.*)\n/
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
        end
      end
      
      def get_description(str)
        if (str.include? "description:")
          match_and_normalize text: str, pattern: /description:\n((#|\*)*\s+(.*)\n)*/, multiline: true
        end
      end
      
      def get_params(str)
        params = []
        mas = /params:\n((#|\*)*\s+(.*)=(.*)\n)*/.match(str)
        mas = mas.to_a
        res = mas[0]
        if !res.nil?
          res = res.gsub(/params:\n/, "")
          matches = res.scan(/(.*)=(.*)\n/).to_a
          matches.each do |m1|
             params << {key: m1[0].gsub(/\s*#*!*/, ""), value: m1[1].strip}
             # m2 = m1.strip
             # pair = m2.split(/\s*=\s*/)
          end
        end
        params
      end
      
      def get_type(str)
        match_and_normalize text: str, pattern: /type:\s*(.*)\n/
      end
      
      def match_and_normalize(text: nil, pattern: //, delimiter: /\s*:\s*/,
         multiline: false)
        ret = nil
        res = pattern.match(text)
        # if a pattern is found
        if !res.nil?
          results = res.to_a
          results[0].gsub(pattern, "")
          title = results[0].split(delimiter)
          ret = title[1].strip
          # if multiline, remove comment marks
          if multiline == true
            ret = ret.gsub(/(#!*|\/\**)*/, "")
            ret = ret.gsub(/\s{2,}/, " ")
            ret = ret.strip
          end
        end
        # return ret
        ret
      end
    
  end
end