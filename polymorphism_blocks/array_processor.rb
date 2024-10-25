# Вариант 2
class ArrayProcessor
	attr_reader: arr

	def initialize(arr)
		@arr = arr.freeze
	end

	# 2. all?
	def all?(&block)
		@arr.each do |element|
			return false unless block.call(element)
		end
		true
	end

	# 14. flat_map
	def flat_map(&block)
		result = []
		@arr.each do |element|
      		result.concat(block.call(element))
    	end
    	result
    end

	# 26. one?
	def one?(&block)
  		@arr.count(&block) == 1
	end

	# 35. inject 
	def inject(initial = nil, &block)
		result = initial
	  	@arr.each do |element|
	    	result = block.call(result, element)
	  	end
	  	result
	end

	# 23. min_by
	def min_by(&block)
		min_element = @arr.first
	    min_value = block.call(min_element)

	    @arr.each do |element|
	    	value = block.call(element)
		    if value < min_value
		    	min_value = value
		        min_element = element
		    end
	    end
	    min_element
	end
end