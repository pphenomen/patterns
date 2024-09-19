# Поиск минимального элемента
def find_min(array)
	min = array[0] # берем минимальный элемент за первый элемент массива

	for element in array # проходимся по массиву и переприсваиваем значение элемента, если он меньше минимального
		if element < min
			min = element
		end
	end
	min
end

# Поиск номера первого положительного элемента 
def find_first_positive_index(array)
	for index in 0...array.size
		if array[index] > 0 # если положительный элемент найден, возвращаем его номер
			return index 
		end
	end
	nil
end

array = [-5,-2,1,6,13]

if array.empty?
	puts "Массив пустой!"
else
	min = find_min(array)
	puts "Минимальный элемент: #{min}"

	first_positive_index = find_first_positive_index(array)
	puts "Номер первого положительного элемента: #{first_positive_index}"
end