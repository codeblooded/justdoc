module Justdoc
  class Markdown
    
    def initialize
      @content = ""
      @current_string = ""
      @constructors_stored = false
      @methods_stored = false
      @properties_stored = false
    end
    
    def respond_to_module(data)
      write_section_with_subsections title: data[:name], level: 4, abstract: data[:abstract], description: data[:description]
    end
    
    def respond_to_class(data)
      write_section_with_subsections title: data[:name], level: 1, abstract: data[:abstract], description: data[:description]
    end
    
    def respond_to_constructor(data)
      if !@constructors_stored
        write_header(text: "Constructors", level: 2)
        @constructors_stored = true
      end
      write_section_with_subsections title: "(new) "+data[:name], level: 3, params: data[:params], returns: data[:returns]
    end
    
    def respond_to_method(data)
      if !@methods_stored
        write_header(text: "Methods", level: 2)
        @methods_stored = true
      end
      write_section_with_subsections title: data[:name], level: 3, abstract: data[:abstract], description: data[:description], params: data[:params], returns: data[:returns]
    end
    
    def respond_to_property(data)
      if !@properties_stored
        write_header(text: "Properties", level: 2)
        @properties_stored = true
      end
      write_section_with_subsections title: data[:name], level: 3, abstract: data[:abstract], description: data[:description]
    end
    
    def end_of_file
      @content
    end
    
    private
      
      def write_section(title: "", level: 1, body: "", newline: false)
        write_header text: title, level: level
        write_body   text: body,  newline: newline
      end
      
      def write_section_with_subsections(title: "", level: 1, abstract: nil, description: nil, params: nil, returns: nil)
        write_header text: title, level: level
        write_whitespace
        if !params.nil?
          write_params_list(params)
          write_whitespace
        end
        if abstract
          write_header text: "Abstract", level: (level + 1)
          write_body   text: abstract
          write_whitespace
        end
        if description
          write_header text: "Description", level: (level + 1)
          write_body   text: description
          write_whitespace
        end
        if returns
          write_header text: "Returns", level: (level + 1)
          write_body   text: returns
          write_whitespace
        end
      end
      
      def write_params_list(params)
        ps = ""
        params.each do |pair|
          key = pair[:key]
          val = pair[:value]
          ps += "- __#{key}__:  _#{val}_\n"
        end
        @content += ps
      end
    
      def write_header(text: "", level: 1)
        hashes = ""
        level.times { hashes += "#" }
        @content += "#{hashes} #{text}\n"
      end
      
      def write_body(text: "", newline: false)
        @content += newline ? "#{text}  \n" : "#{text}\n"
      end
      
      def write_whitespace
        @content += "\n"
      end
  end
end
