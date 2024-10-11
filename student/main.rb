require './student.rb'

student1 = Student.new({second_name: "Иванов", first_name: "Иван", patronymic: "Иванович", git: "github.com/ivanov"})
student1.set_contacts({phone_number: "89123456789"})

student2 = Student.new(
	second_name: "Petrov", 
	first_name: "Petr", 
	patronymic: "Petrovich", 
	id: 2, 
	phone_number: "89674549878", 
	git: "github.com/petr"
)

puts student1.get_info
puts student2
