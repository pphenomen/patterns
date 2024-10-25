# 1.2 Дан целочисленный массив. Необходимо найти индекс минимального элемента
def find_min_index(arr)
	arr.index(arr.min)
end

# 1.14 Дан целочисленный массив и интервал a..b. Необходимо найти количество элементов в этом интервале.
def count_in_interval(arr, a, b)
	arr.count { |num| num.between?(a,b) }
end

# 1.26 Дан целочисленный массив. Необходимо найти количество элементов между первым и последним минимальным.
def count_between_mins(arr)
	min_value = arr.min
	first_min_index = arr.index(min_value)
	last_min_index = arr.index(min_value)
	return 0 if first_min_index == last_min_index 

	arr[first_min_index + 1...last_min_index].size
end

# 1.38 Дан целочисленный массив и отрезок a..b. Необходимо найти количество элементов, значение которых принадлежит этому отрезку.
def count_in_section(arr)
	arr.count { |num| num.between?(a,b)}
end

# 1.50 Для двух введенных списков L1 и L2 построить новый список, состоящий из элементов, встречающихся только в одном из этих списков и не повторяющихся в них.
def create_list_of_unique_elements(l1,l2)
	(l1 | l2) - (l1 & l2)
end
