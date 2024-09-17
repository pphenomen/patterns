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

