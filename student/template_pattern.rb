class Gym
	attr_accessor :kg

	def initialize
		self.kg = 20
	end

	def workout
		warm_up
		do_exercise
		rest
	end

	private

	def warm_up
		puts "Разминка"
	end

	def do_exercise
		raise NotImplementedError, "Метод не реализован в классе"
	end 

	def rest
		puts "Отдых"
	end
end

class BenchPress < Gym
	def do_exercise
		puts "Выполняем жим лежа с весом #{kg} кг"
		self.kg += 80
		puts "Переходим к рабочему подходу #{kg} кг"
	end
end

class Deadlift < Gym
	def do_exercise
		puts "Выполняем становую тягу с весом #{kg} кг"
		self.kg += 180
		puts "Переходим к рабочему подходу #{kg} кг"
	end
end

bench_press = BenchPress.new
deadlift = Deadlift.new

puts bench_press.workout
puts deadlift.workout