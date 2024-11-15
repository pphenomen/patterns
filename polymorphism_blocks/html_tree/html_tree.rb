require './html_tag.rb'

class HtmlTree
	include Enumerable

	attr_reader :root

  	def initialize(html)
    	@root = parse_html(html)
  	end

  	def parse_html(html)
    	stack = []
    	current_node = nil

    	html.scan(/<(\w+)([^>]*)>|<\/(\w+)>|([^<]+)/).each do |open_tag, attrs, close_tag, content|
	      	if open_tag
	        	attributes = parse_attributes(attrs.strip)
	        	new_node = HtmlTag.new(tag_name: open_tag, attributes: attributes)

	        	if current_node.nil?
	          		current_node = new_node
	          		@root = current_node
	        	else
	          		current_node.add_child(new_node)
	          		stack.push(current_node)
	          		current_node = new_node
	        	end
	      	elsif close_tag
	        	current_node = stack.pop unless stack.empty?
	        elsif content && !content.strip.empty?
	        	current_node.content = content.strip if current_node
	      	end
    	end
    	@root
  	end

  	def parse_attributes(attributes_string)
    	attributes_string.scan(/(\w+)=["'](.*?)["']/).to_h
  	end

  	def bfs
		return if @root.nil?

	    queue = [@root]
	    while queue.any?
	    	current_node = queue.shift
	      	yield(current_node)
	     	queue.concat(current_node.children)
	    end
	end

	def dfs
	    return if @root.nil?

	    stack = [@root]
	    while stack.any?
	    	current_node = stack.pop
	    	yield(current_node)
	    	current_node.children.reverse.each { |child| stack.push(child) } # reverse для сохранения порядка
	    end
	end

	def each(&block)
	    dfs(&block)
	end

  	def to_s
    	@root.to_s
  	end
end
