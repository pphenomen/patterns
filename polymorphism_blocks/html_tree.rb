class Tree
	include Enumerable

	attr_accessor :root

	def initialize(root = nil)
		@root = root
	end

	def each(&block)
	    dfs(&block)
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

	def add_child(node, parent = nil)
	    if parent.nil?
	    	@root = node
	    else
	      	parent.add_child(node)
	    end
	end
end

class HtmlTag
	attr_reader :tag_name, :attributes, :children
	attr_accessor :content 

	def initialize(tag_name:, attributes: {}, content: nil)
		@tag_name = tag_name
		@attributes = attributes
		@content = content
		@children = []
	end

	def add_child(tag)
		@children << tag if tag.is_a?(HtmlTag)
	end

	def count_children
		children.size
	end

	def has_children?
		!children.empty?
	end

	def to_s(indent = 0)
		indentation = '  ' * indent
		opening_tag = "<#{tag_name}#{attributes_string}>"
		closing_tag = "</#{tag_name}>"

		if content.nil? && children.empty?
			"#{indentation}#{opening_tag}/>\n"
		else
			result = "#{indentation}#{opening_tag}\n"
			result += "#{indentation}  #{content}\n" if content
			children.each { |child| result += child.to_s(indent + 1) }
			result += "#{indentation}#{closing_tag}\n"
			result
		end
	end

	def attributes_string
		attributes.map { |key, value| " #{key}='#{value}'" }.join
	end

	def children_string
		children.map(&:to_s).join
	end
end

class HtmlTree < Tree

  	def initialize(html)
    	super()
    	parse_html(html)
  	end

  	def parse_html(html)
    	stack = []
    	current_node = nil

    	html.scan(/<\/?(\w+)(.*?)\/?>/) do |tag_open, attrs|
	      	if tag_open
	        	attributes = parse_attributes(attrs.strip)
	        	new_node = HtmlTag.new(tag_name: tag_open, attributes: attributes)

	        	if current_node.nil?
	          		current_node = new_node
	          		@root = current_node
	        	else
	          		current_node.add_child(new_node)
	          		stack.push(current_node)
	          		current_node = new_node
	        	end
	      	else
	        	current_node = stack.pop unless stack.empty?
	      	end
    	end
  	end

  	def parse_attributes(attributes_string)
    	attributes_string.scan(/(\w+)=["'](.*?)["']/).to_h
  	end

  	def to_s
    	@root.to_s
  	end
end

html = "<html><body><h1 class='title'>Hello, World!</h1><p>Welcome to the club buddy</p></body></html>"
html_tree = HtmlTree.new(html)

puts html_tree

puts "\nHTML tree (BFS):"
html_tree.bfs { |node| puts node.tag_name }

puts "\n\nHTML tree (DFS):"
html_tree.dfs { |node| puts node.tag_name }

puts "\neach(DFS):"
html_tree.each { |node| puts node.tag_name }

puts "\nCount children for each node:"
html_tree.each { |node| puts "#{node.tag_name} has #{node.count_children} child(ren)." }

puts "\nHas children?"
html_tree.each { |node| puts "#{node.tag_name} has children: #{node.has_children?}" }