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

if ARGV.size != 2
  puts "Неверное количество аргументов. Пример использования: ruby program.rb <method> <file>"
  exit
end

method = ARGV[0] # первый аргумент - метод
file_path = ARGV[1] # второй аргумент - путь к файлу

# Чтение данных из файла
if File.exist?(file_path)
  content = File.read(file_path) # читаем содержимое файла как строку
  array = content.split.map(&:to_i) # разделяем строку на части и преобразуем в числа
else
  puts "Файл не найден: #{file_path}" # сообщение, если файл не найден
  exit                             
end

# В зависимости от выбранного метода, вызываем соответствующую функцию
case method
when "find_min"
  result = find_min(array)
  if result.nil?
    puts "Массив пустой!"
  else
    puts "Минимальный элемент: #{result}"
  end
when "find_first_positive_index"
  result = find_first_positive_index(array)
  if result.nil?
    puts "Положительные элементы отсутствуют!"
  else
    puts "Номер первого положительного элемента: #{result}"
  end
else
  puts "Неверное название метода. Доступные методы: find_min, find_first_positive_index"
end