# 1.2 Дан целочисленный массив. Необходимо найти индекс минимального элемента
def find_min_index(arr)
	arr.index(arr.min)
end

# 1.14 Дан целочисленный массив и интервал a..b. Необходимо найти количество элементов в этом интервале.
def count_in_interval(arr, a, b)
	arr.count { |num| num.between?(a,b) }
end