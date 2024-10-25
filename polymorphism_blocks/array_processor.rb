# Вариант 2
class ArrayProcessor
	attr_reader	:arr

	def initialize(arr)
		@arr = arr.freeze
	end
end