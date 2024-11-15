require 'minitest/autorun'
require './array_processor.rb'

class TestArrayProcessor < Minitest::Test
	
	def test_all
		array = ArrayProcessor.new([2, 4, 6, -8])
		assert(array.all? { |num| num.even? })

		array = ArrayProcessor.new([1, 2, 3, 4, 5])
		assert(array.all? { |num| num > 0 })

		array = ArrayProcessor.new([1, 2, -3, 4, -5])
		refute(array.all? { |num| num > 0 })

		array = ArrayProcessor.new([])
		assert(array.flat_map { |num| num.even? }, [])
	end

	def test_flat_map
		array = ArrayProcessor.new([1..3, 4..8]) 
		assert(array.flat_map { |range| range.to_a }, [1, 2, 3, 4, 5, 6, 7, 8])

		array = ArrayProcessor.new([1, 2, 3, 4])
		assert(array.flat_map { |num| [num, num * 2] }, [1, 2, 2, 4, 3, 6, 4, 8])

		array = ArrayProcessor.new([])
		assert(array.flat_map { |num| [num, num * 2] }, [])
	end

	def test_one
		array = ArrayProcessor.new([1, 2, 3, 4, 5])
		assert(array.one? { |num| num == 3 })
		refute(array.one? { |num| num < 0 })

		array = ArrayProcessor.new([-1, 2, -3, 8])
		assert(array.one? { |num| num.even? && num == 2 })
		refute(array.one? { |num| num == 6 })
	end

	def test_inject
		array = ArrayProcessor.new([1, 2, 3, 4, 5])
		assert(array.inject(:+) { |num| num }, [15])

		array = ArrayProcessor.new([1, 2, 3, 4, 5])
		assert(array.inject(10) { |sum, num| sum + num }, [25]) # 10 + 1 + 2 + 3 + 4 + 5

		array = ArrayProcessor.new(['When', 'will', 'it', 'end'])
		assert(array.inject { |concat, str| concat + str }, ['When will it end'])
	end

	def test_min_by
		array = ArrayProcessor.new([5, 3, 8, 1, 4])
		assert(array.min_by { |num| num }, [1])

		array = ArrayProcessor.new(['ruby', 'python', 'java', 'go'])
		assert(array.min_by { |str| str.length }, ['go'])

		array = ArrayProcessor.new([])
		assert(array.flat_map { |num| num }, [])
	end

	def test_find
		array = ArrayProcessor.new([
			{ name: "Ivan", age: 30 }, 
			{ name: "Maga", age: 20 }, 
			{ name: "Khabib", age: 36 }
		])
		assert(array.find { |person| person[:name] == "Maga" }, { name: "Maga", age: 20 })

		array = ArrayProcessor.new([1, 3, 5, 6, 7])
		assert(array.find { |num| num.even? }, [6])

		array = ArrayProcessor.new([])
		assert(array.flat_map { |num| num.even? }, [])
	end 
end