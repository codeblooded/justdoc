# Testing

Testing is crucial to the Justdoc project. Without testing, there is no way 
to be certain if documentation is truly documented correctly.  Because it
is so vital to Justdoc, all pull requests should provide a test.  Here is how
tests are divided into directories within Justdoc:

## Communicating

The communicating subdirectory contains tests that involve mainly communicating
with external APIs.  In the case of Justdoc, these are mainly tests of
communicating changes between the project and GIT.

## Documenting

The documenting subdirectory contains tests for parsing and dividing comments into 
the appropriate documentation fields.  These are mainly tests of regular
expressions and the returned values from the Justdoc::Recognizer.

## Generating

The generating subdirectory contains tests for generating varies formats and files
of the documentation.  For example, the type of header a class uses in Markdown is 
tested here.  This is mainly used for testing the Justdoc::Generator and 
Justdoc::Output.

## Reading

The reading subdirectory contains tests for reading the appropriate inputs from the
files and from the user with the command line tool.  These mainly test the
executable in bin/justdoc and the Justdoc::Reader.

If contributing to the project, please attempt to place the tests where they seem
appropriate.  If you have any questions, just ask :).
