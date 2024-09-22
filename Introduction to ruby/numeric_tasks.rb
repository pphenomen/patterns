# Методы для работы с цифрами, вариант №2

# Метод 1. Найти количество чисел, взаимно простых с заданным
# Поиск НОД алгоритмом Евклида 
def gcd(num1, num2)
	while (num2 != 0)
		num1, num2 = num2, num1 % num2 # заменяем num1 на num2, а num2 - на остаток от деления num1 на num2
	end 
	num1 # возвращаем num1, когда num2 = 0, нод найден
end
# Подсчет взаимно простых чисел (если нод числа и текущее число = 1, => взаимно простые)
def count_coprimes(number)
	count = 0
	(1..number).each do |current_number| 
		count += 1 if gcd(number, current_number) == 1 
	end
	count
end

# Метод 2. Найти сумму цифр числа, делящихся на 3
def sum_of_digits_div_by_3(number)
  sum_digits = 0
  number = number.abs # берем в модуль для обработки положительных и отрицательных чисел
  
  while number > 0
    digit = number % 10 # извлекаем крайнюю цифру числа
    sum_digits += digit if digit % 3 == 0 # добавляем цифру к сумме, если подходит под условие
    number /= 10 # отбрасываем крайнюю цифру, чтобы обработать следующую
  end
  sum_digits
end

# Метод 3. Найти делитель числа, являющийся взаимно простым с наибольшим количеством цифр данного числа
# Поиск делителей числа
def find_divisors(number)
  divisors = [] 
  (1..number).each do |divisor|
    divisors << divisor if number % divisor == 0 # проверяем, делится ли число на делитель без остатка, если да, то добавляем в массив 
  end
  divisors
end
# Нахождение цифр числа
def get_digits(number)
  digits = []
  if number == 0 # проверка на ноль, чтобы избежать получения пустого массива 
  	digits << 0
  else
  	while number > 0
  		digits << number % 10 # добавляем крайнюю цифру числа
	    number /= 10 # убираем крайнюю цифру
	  end
  end
  digits.reverse # разворачиваем массив, чтобы получить цифры в правильном порядке
end
# Поиск количества взаимно простых цифр
def count_coprime_digits(divisor, number)
	digits = get_digits(number)
	count = 0
	digits.each do |digit| # проходим по каждой цифре из массива digits и считаем количество взаимно простых цифр
		next if digit == 0 # пропуск нуля, т.к. нод(число,0) = число, => проверка не имеет смысла
		count += 1 if gcd(divisor,digit) == 1
	end
	count
end
# Поиск делителя, который является взаимно простым с наибольшим количеством цифр числа
def find_right_divisor(number)
	divisors = find_divisors(number)
	right_divisor = nil
	max_coprime_digits = 0

	divisors.each do |divisor| # проходим по каждому делителю 
		coprime_digits = count_coprime_digits(divisor, number) # вычисляется количество цифр числа, которые являются взаимно простыми с делителем и передаются в массив
		if coprime_digits > max_coprime_digits # если текущее количество взаимно простых цифр больше предыдущего максимального, обнrовляем значение максимального и сохраняем текущий делитель как правильный
			max_coprime_digits = coprime_digits 
			right_divisor = divisor
		end
	end
	right_divisor
end