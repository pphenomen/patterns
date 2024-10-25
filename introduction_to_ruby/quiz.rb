# Принимаем имя пользователя как значение аргумента
username = ARGV[0] || "Пользователь"

# Приветствие пользователя
puts "Салам, #{username}"

# Спрашиваем любимый ЯП
puts "Какой язык программирования у тебя любимый?"
favourite_language = STDIN.gets.chomp

# Опрос пользователя
case favourite_language
	when 'ruby'
		puts "Ты подлиза!"
	when 'python'
		puts "Ты герпетолог?"
	when 'javascript'
		puts "Может все таки Java?"
	when 'c#'	
		puts "А ты хорош!"
	else
		puts "Если любишь - отпусти... скоро будет ruby"
end

# Просим пользователя ввести команду языка ruby
puts "Введи команду языка ruby"
eval(STDIN.gets.chomp) # eval выполняет команду ruby

# Просим пользователя ввести команду ОС
puts "Введи команду операционной системы"
system(STDIN.gets.chomp) # system выполняет команду ОС