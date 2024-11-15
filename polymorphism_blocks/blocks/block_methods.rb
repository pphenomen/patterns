# 1.2 Дан целочисленный массив. Необходимо найти индекс минимального элемента
def find_min_index(arr)
	arr.index(arr.min)
end

# 1.14 1.38 Дан целочисленный массив и интервал a..b. Необходимо найти количество элементов в этом интервале.
def count_in_interval(arr, a, b)
	arr.count { |num| num.between?(a,b) }
end

# 1.26 Дан целочисленный массив. Необходимо найти количество элементов между первым и последним минимальным.
def count_between_mins(arr)
	min_value = arr.min
	first_min_index = arr.index(min_value)
	last_min_index = arr.rindex(min_value)
	return 0 if first_min_index == last_min_index 

	arr[first_min_index + 1...last_min_index].size
end

# 1.50 Для двух введенных списков L1 и L2 построить новый список, состоящий из элементов, встречающихся только в одном из этих списков и не повторяющихся в них.
def create_list_of_unique_elements(l1, l2)
	(l1 - l2) + (l2 - l1)
end

def input_array
	puts "Введите массив целых чисел (через пробел):"
	gets.chomp.split.map(&:to_i)
end

def input_interval
  	puts "Введите границы интервала a и b (через пробел):"
  	gets.chomp.split.map(&:to_i) 
end

# Выбор пользователя
puts "\nВыберите задачу(1-5):"
puts "1. Найти индекс минимального элемента"
puts "2. Найти количество элементов в интервале a..b"
puts "3. Найти количество элементов между первым и последним минимальным"
puts "4. Найти количество элементов в отрезке a..b"
puts "5. Построить новый список из уникальных элементов, встречающихся только в одном из двух списков"
choice = gets.to_i

case choice
when 1
	arr = input_array
	puts "Индекс минимального элемента: #{find_min_index(arr)}"
when 2
	arr = input_array
	a, b = input_interval
	puts "Количество элементов в интервале #{a}..#{b}: #{count_in_interval(arr, a, b)}"
when 3
	arr = input_array
	puts "Количество элементов между первым и последним минимальным: #{count_between_mins(arr)}"
when 4
	arr = input_array
	a, b = input_interval
	puts "Количество элементов в отрезке #{a}..#{b}: #{count_in_interval(arr, a, b)}"
when 5
	puts "Введите список чисел L1 (через пробел):"
  	l1 = gets.chomp.split.map(&:to_i)
  	puts "Введите список чисел L2 (через пробел):"
  	l2 = gets.chomp.split.map(&:to_i) 
	result = create_list_of_unique_elements(l1,l2)
	puts "Новый список уникальных элементов: #{result}"
else 
	puts "Неверный выбор"
end