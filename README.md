# Justdoc

_NOTE: THIS PROJECT IS IN DEVELOPMENT._

A simple documentation generator that does the hard work, keeps comments readable, and does not require large configuration files. 

## Installation

JustDoc, once stable, will be packaged as a RubyGem. It requires Ruby 2.0 or greater installed. Then you can simply run:

    $ gem install justdoc
    
However, right now it must be installed by cloning the Github repo, navigating to the directory and running:

    $ rake install

Although having Git installed is no longer a requirement, it is still __highly recommended__. 

## Usage

To initially setup documentation in a repo, tell JustDoc to track the current directory recursively:

    $ justdoc setup

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

## Documentation
To document code, simply use comments with an added ! (exclamation point).  If your language supports multiline comments, documentation must be written using `/*! */` instead of `//!`.  For Ruby, declare documentation with `#!` and finish with `#!!`. The following chart shows the syntax of the documentation. It is written using Ruby, but the syntax remains the same across languages.

<table>
  <tr><th colspan="2" style="text-align:center;">Documentation Syntax Table</th></tr>
  <tr>
    <td>Modules</td>
    <td>
    <pre>      #! module: Creature
      #
      # abstract: The module of Creatures.
      #!!
      module Creature</pre></td>
  </tr>
  <tr>
    <td>Classes</td>
    <td>
    <pre>      #! class: Human
      #
      # abstract: Defines Characteristics and Methods of a Human.
      #
      # description:
      #    The human class inherits methods from the Animal class.
      #    It allows methods to be called on a human object.
      #!!
      class Human &lt; Animal</pre></td>
  </tr>
  <tr>
    <td>Methods</td>
    <td>
    <pre>      #! method: have_dinner(food, drink)
      #
      # abstract: Called during the dinner mealtime.
      #
      # params:
      #    food  = The food to eat
      #    drink = The drink during the main course
      #
      # description:
      #    Have dinner allows a human to eat during the evening time.
      #    To eat about noon, {see: have_lunch(food, drink)}
      #!!
      def have_dinner(food, drink)</pre></td>
  </tr>
  <tr>
    <td>Properties</td>
    <td>
    <pre>      #! var: weight
      # type: string
      # abstract: The weight of the human.
      #
      # description:
      #    Get/Set the weight of the human.
      #!!
      attr_accessible :weight</pre></td>
  </tr>
</table>

## Caveats
Justdoc is still being _actively developed_.  It currently has a problem with any documentation containing a colon, because
the colon serves as the main delimiter.  In a stable release, we will silence scanning of 'quotes' containing colons.  Developers
will be able to use colons in practically every section by wrapping it in a quote.  As of now, this is the biggest bug.  Please
report an issue if you find another.

## Contributing

Please read the [Contributing Guidelines](https://github.com/codeblooded/justdoc/blob/master/CONTRIBUTING.md) before contributing to the project.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
