require './student.rb'

student1 = Student.new(
	second_name: "Ivanov", 
	first_name: "Ivan", 
	patronymic: "Ivanovich",
	id: 1,
	phone_number: "89287142211",
	git: "github.com/ivan"
)
student2 = Student.new(
	second_name: "Petrov", 
	first_name: "Petr", 
	patronymic: "Petrovich", 
	id: 2, 
	phone_number: "89674549878", 
	git: "github.com/petr"
)
student3 = Student.new(
	second_name: "Sidorova", 
	first_name: "Maria", 
	patronymic: "Ivanovna", 
	id: 3, 
	phone_number: nil, 
	git: nil
)

puts student1
puts student2
puts student3