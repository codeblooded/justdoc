module Justdoc
  class Markdown
    
    def initialize
      @content = ""
      @current_class = ""
      @methods_stored = false
    end
    
    def respond_to_module(data)
      @content = "#{data.name}" + @content
    end
    
    def respond_to_class(data)
      @current_class = data[:name]
      @content += "# #{data[:name]}\n## Abstract\n#{data.abstract}\n## Description#{data.description}"
    end
    
    def respond_to_method(data)
      @current_class = data[:name]
      @content = @content + "## Methods" if !@methods_stored
    end
    
    def respond_to_property(data)
      
    end
    
    def end_of_file(data)
      data
    end
    
  end
end
