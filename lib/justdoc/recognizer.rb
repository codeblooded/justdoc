# Copyright (c) 2013 Benjamin Reed 
# Licensed under the MIT License (see LICENSE.txt)
# 
# recognizer.rb
# -----------------------------------------------------------------------
# The abstraction of recognizing the sytax of specific languages 
# and their commenting syntax.
require 'debugger'

module Justdoc
  #! class: Recognizer
  #  abstract: Recognizes Documentation in Comments
  #  description:
  #    The abstraction of recognizing documentation in files.
  #!!
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
        elsif match.include? "constructs:"
          scan_constructor(match)
        elsif match.include? "method:"
          scan_method(match)
        elsif match.include? "var:"
          scan_property(match)
        end
      end
    
      #! module: scan_module
      #  abstract: Scans a module for documentation
      #  params:
      #    str = The unsanitized match containing the module documentation.
      #  description:
      #    Calls appropriate modules and generates a hash to add the module
      #    to the documents.
      #!!
      def scan_module(str)
        module_name = match_and_normalize text: str, pattern: /module:\s*(.*)\n/
        @documents[:modules] << {name: module_name, 
          abstract: get_abstract(str), description: get_description(str)}
      end
      
      #! class: scan_class
      #  abstract: Scans a class for documentation
      #  params:
      #    str = The unsanitized match containing the class documentation.
      #  description:
      #    Calls appropriate classs and generates a hash to add the class
      #    to the documents.
      #!!
      def scan_class(str)
        class_name = match_and_normalize text: str, pattern: /class:\s*(.*)\n/
        @documents[:classes] << {name: class_name, 
          abstract: get_abstract(str), description: get_description(str)}
      end
      
      #! constructor: scan_constructor
      #  abstract: Scans a constructor for documentation
      #  params:
      #    str = The unsanitized match containing the constructor documentation.
      #  description:
      #    Calls appropriate constructors and generates a hash to add the constructor
      #    to the documents.
      #!!
      def scan_constructor(str)
        constructs = match_and_normalize text: str, pattern: /constructs:\s*(.*)\n/
        returns    = get_returns(str) || "A new instance of #{constructs}"
        @documents[:constructors] << {name: constructs, 
          abstract: get_abstract(str), description: get_description(str), 
          params: get_params(str), returns: returns}
      end
      
      #! method: scan_method
      #  abstract: Scans a method for documentation
      #  params:
      #    str = The unsanitized match containing the method documentation.
      #  description:
      #    Calls appropriate methods and generates a hash to add the method
      #    to the documents.
      #!!
      def scan_method(str)
        method_name = match_and_normalize text: str, pattern: /method:\s*(.*)\n/
        @documents[:methods] << {name: method_name, 
          abstract: get_abstract(str), description: get_description(str), 
          params: get_params(str), returns: get_returns(str)}
      end
      
      #! method: scan_property
      #  abstract: Scans a property for documentation
      #  params:
      #    str = The unsanitized match containing the property documentation.
      #  description:
      #    Calls appropriate methods and generates a hash to add the property
      #    to the documents.
      #!!
      def scan_property(str)
        property_name = match_and_normalize text: str, pattern: /var:\s*(.*)\n/
        @documents[:properties] << {name: property_name, 
          abstract: get_abstract(str), description: get_description(str), 
          type: get_type(str)}
      end
    
      #! method: get_abstract
      #  abstract: Gets the abstract section for any documentation
      #  params:
      #    str = The unsanitized comment of the method.
      #  description:
      #    Uses match_and_normalize to match and return the abstract section.
      #  returns: The abstract section
      #!!
      def get_abstract(str)
        if (str.include? "abstract:")
          match_and_normalize text: str, pattern: /abstract:(\s+(.*)\n)/
        end
      end
      
      #! method: get_description
      #  abstract: Gets the description for any documentation
      #  params:
      #    str = The unsanitized comment of the method.
      #  description:
      #    Uses match_and_normalize with multiline to true to match and return the full description.
      #  returns: The full description
      #!!
      def get_description(str)
        if (str.include? "description:")
          match_and_normalize text: str, pattern: /description:\n((#|\*)*\s+(.*)\n)*/, multiline: true
        end
      end
      
      #! method: get_params
      #  abstract: Gets the parameters of a Method
      #  params:
      #    str = The unsanitized comment of the method.
      #  description:
      #    Scans the parameters of a Method.  Doesn't rely on the match_and_normalize method, because
      #    it contains an irregular syntax.
      #  returns: Array of parameters for a method
      #!!
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
      
      #! method: get_returns
      #  abstract: Gets what a Method Returns
      #  params:
      #    str = The unsanitized comment of the method.
      #  description:
      #    Gets what a method returns if it contains a returns statement.
      #  returns: What a method returns or nil
      #!!
      def get_returns(str)
        if (str.include? "returns:")
          match_and_normalize text: str, pattern: /returns:\s*(.*)\n/
        end
      end
      
      #! method: get_type
      #  abstract: Gets a Match for the Type of Property
      #  params:
      #    str = The unsanitized comment of the property.
      #  description:
      #    Gets the data type specified for a property.
      #  returns: Property's Data Type or nil
      #!!
      def get_type(str)
        if (str.include? "type:")
          match_and_normalize text: str, pattern: /type:\s*(.*)\n/
        end
      end
      
      #! method: match_and_normalize
      #  abstract: Matches a Pattern and Sanitizes the Result
      #  params:
      #    text      = The string to check
      #    pattern   = The regex to match
      #    delimiter = The regex to split data upon
      #    multiline = A boolean indicating if it should normalize across multiple lines
      #  description:
      #    Matches a string, text, against a regex, pattern, and splits the results
      #    using the delimiter which defaults to a colon and surrounding whitespace.
      #    Finally, it checks if it should normalize across multiple lines using, multiline.
      #    Unless specified, it assumes multiline to false.
      #  returns: The second element in the match split on the delimiter, or nil.
      #!!
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