class ExerciseStrategy
	def do_exercise(kg)
		raise NotImplementedError, "Метод должен быть реализован в подклассе"
  	end
end

class BenchPress < ExerciseStrategy
	def do_exercise(kg)
		puts "Тренировка жима лежа. Разминка с весом #{kg} кг"
		kg += 80
		puts "Переходим к рабочему подходу #{kg} кг"
		kg
	end
end

class Deadlift < ExerciseStrategy
	def do_exercise(kg)
		puts "Тренировка становой тяги. Разминка с весом #{kg} кг"
		kg += 50
		puts "Переходим к рабочему подходу #{kg} кг"
		kg
	end
end

class Gym
	attr_accessor :kg, :strategy

	def initialize
		@kg = 20
	end

	def set_strategy(strategy)
		@strategy = strategy
	end

	def workout_process
		puts "\nНачинаем тренировку!"
		@kg = @strategy.do_exercise(@kg)
    	puts "Тренировка завершена. Итоговый вес: #{@kg} кг"
	end
end

bench_press = BenchPress.new
deadlift = Deadlift.new
workout = Gym.new

workout.set_strategy(bench_press)
workout.workout_process

workout.set_strategy(deadlift)
workout.workout_process