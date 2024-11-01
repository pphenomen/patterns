class ArrayProcessor
	attr_reader :arr

	def initialize(arr)
		@arr = arr.freeze
	end

	def all?
		@arr.each { |element| return false unless yield(element) }
		true
	end

	def flat_map
		result = []
		@arr.each { |element| result.concat(yield(element)) }
    	result
    end

	def one?
		count = 0
  		@arr.each do|element| 
  			count += 1 if yield(element) 
  			return false if count > 1
  		end
  		count == 1
	end
	
	def inject(initial = nil)
		result = initial.nil? ? @arr.first : initial
	  	@arr.each { |element| result = yield(result, element) }
	  	result
	end

	def min_by
		min_element = @arr.first
	    min_value = yield(min_element)

	    @arr.each do |element|
	    	value = yield(element)
		    if value < min_value
		    	min_value = value
		        min_element = element
		    end
	    end
	    min_element
	end
    
	def find
    	@arr.each { |element| return element if yield(element) } 
    	nil
    end
end