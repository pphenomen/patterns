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