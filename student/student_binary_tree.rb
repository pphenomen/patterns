require './student.rb'

class StudentBinaryTree
	include Enumerable

	class Node
		attr_accessor :student, :left, :right

		def initialize(student)
			@student = student
			@left = nil
			@right = nil
		end
	end

	def initialize
		@root = nil
	end

	def insert(student)
		unless student.is_a?(Student)
			raise ArgumentError, "Объект должен быть экземпляром класса Student"
		end

		if @root.nil?
			@root = Node.new(student)
		else
			insert_node(@root, student)
		end
	end

	def each(&block)
		inorder_traversal(@root, &block)
	end

	private 

	def insert_node(node, student)
    	if student < node.student
      		if node.left.nil?
        		node.left = Node.new(student)
      		else
        		insert_node(node.left, student)
      		end
    	else
      		if node.right.nil?
        		node.right = Node.new(student)
      		else
        		insert_node(node.right, student)
      		end
    	end
	end

  	def inorder_traversal(node, &block)
    	return if node.nil?

    	inorder_traversal(node.left, &block)
    	yield(node.student)
    	inorder_traversal(node.right, &block)
    end
end