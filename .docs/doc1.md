# Recognizer
## Abstract
Recognizes Documentation in Comments
## Description
The abstraction of recognizing documentation in files.
## Methods
### Recognizer
#### Abstract

#### Description

#### Returns
A new instance of Recognizer
### recognize
- __x__:  _The String to match_
- __style__:  _The Style of Comments (C-Style or Ruby-Style)_
#### Abstract
Recognizes documentation in comments
#### Description
A method that recognizes comments with an ! implying the use of Justdoc to document.
### scan_matches
#### Abstract
Passes each match to be ordered and documented.
#### Description
scan_matches iterates over each match and passes the match to find_type_and_document, a private method in the Recognizer class. It relies on the @matches instance variable to be set. returns
#### Returns
The ordered documents
### documents
#### Abstract

#### Description
A method used primarily for testing purposes. (DEPRECATED) returns
#### Returns
The ordered documents
### find_type_and_document
- __match__:  _The string to accept_
#### Abstract
Finds type and documents
#### Description
Finds the type of document and directs to appropriate method.
### scan_module
- __str__:  _The unsanitized match containing the module documentation._
#### Abstract
Scans a module for documentation
#### Description
Calls appropriate modules and generates a hash to add the module to the documents.
### scan_class
- __str__:  _The unsanitized match containing the class documentation._
#### Abstract
Scans a class for documentation
#### Description
Calls appropriate classs and generates a hash to add the class to the documents.
### scan_method
- __str__:  _The unsanitized match containing the method documentation._
#### Abstract
Scans a method for documentation
#### Description
Calls appropriate methods and generates a hash to add the method to the documents.
### scan_property
- __str__:  _The unsanitized match containing the property documentation._
#### Abstract
Scans a property for documentation
#### Description
Calls appropriate methods and generates a hash to add the property to the documents.
### get_abstract
- __str__:  _The unsanitized comment of the method._
#### Abstract
Gets the abstract section for any documentation
#### Description
Uses match_and_normalize to match and return the abstract section. returns
#### Returns
The abstract section
### get_description
- __str__:  _The unsanitized comment of the method._
#### Abstract
Gets the description for any documentation
#### Description
Uses match_and_normalize with multiline to true to match and return the full description. returns
#### Returns
The full description
### get_params
- __str__:  _The unsanitized comment of the method._
#### Abstract
Gets the parameters of a Method
#### Description
Scans the parameters of a Method. Doesn't rely on the match_and_normalize method, because it contains an irregular syntax. returns
#### Returns
Array of parameters for a method
### get_returns
- __str__:  _The unsanitized comment of the method._
#### Abstract
Gets what a Method Returns
#### Description
Gets what a method returns if it contains a returns statement. returns
#### Returns
What a method returns or nil
### get_type
- __str__:  _The unsanitized comment of the property._
#### Abstract
Gets a Match for the Type of Property
#### Description
Gets the data type specified for a property. returns
#### Returns
Property's Data Type or nil
### match_and_normalize
- __text__:  _The string to check_
- __pattern__:  _The regex to match_
- __delimiter__:  _The regex to split data upon_
- __multiline__:  _A boolean indicating if it should normalize across multiple lines_
#### Abstract
Matches a Pattern and Sanitizes the Result
#### Description
Matches a string, text, against a regex, pattern, and splits the results using the delimiter which defaults to a colon and surrounding whitespace. Finally, it checks if it should normalize across multiple lines using, multiline. Unless specified, it assumes multiline to false. returns
#### Returns
The second element in the match split on the delimiter, or nil.
