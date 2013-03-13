# Justdoc

A simple documentation generator that does the hard work, keeps comments readable, and does not require large configuration files. 

## Installation

JustDoc is packaged as a RubyGem. It requires Ruby 2.0 or greater installed. To install, simply run:

    $ gem install justdoc

__NOTE: It is required that GIT be installed on your system and used in the project to be documented.__

## Usage

To initially setup documentation in a repo, tell JustDoc to track the current directory recursively:

    $ justdoc track

And you'll be prompted to answer some questions. This is a one time thing, and you should never have to worry about configuring again.  

Now, JustDoc follows GIT to track whether or not certain files need the documentation updated. To generate/update documentation for files staged in GIT, simply run:

    $ justdoc run

And that's it! All your documentation will be generated. Of course there's more commands, but this is enough to get started.

## Languages
Being a documentation generator means that the project needs familiarity with syntactical aspects of the languages.  So far, the following languages are supported. We are currently working to add languages, and the status of languages is provided on the [Languages Wiki Page]().  

  - Ruby
  - C/C++  
  - Objective-C  
  - C#  
  - Java

## Contributing

Please read the [Contributing Guidelines](https://github.com/codeblooded/justdoc/blob/master/CONTRIBUTING.md) before contributing to the project.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
