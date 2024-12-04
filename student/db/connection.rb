require 'pg'

begin
	connection = PG.connect(
		dbname: 'StudentsDB',
		user: 'postgres',
		password: '0311',
		host: 'localhost',
		port: 5432
		)
	puts "Соединение с базой установлено"

	result = connection.exec("SELECT * FROM student;")
	result.each do |row|
		puts "ID: #{row['id']}, ФИО: #{row['second_name']} #{row['first_name']} #{row['patronymic']}, Дата рождения: #{row['birthdate']}, 
		Телефон: #{row['phone_number']}, Email: #{row['email']}, Telegram: #{row['telegram']}, Git: #{row['git']}"
  	end

rescue PG::Error => e
	puts "Ошибка подключения или выполнения запроса: #{e.message}"
ensure
	connection.close if connection
end