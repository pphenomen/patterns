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
end