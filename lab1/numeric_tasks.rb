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
	puts "Количество чисел, взаимно простых с заданным: #{count}"
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
  
  puts "Сумма цифр числа, делящихся на 3: #{sum_digits}"
end