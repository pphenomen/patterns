require './student.rb'

student = Student.new({
	second_name: "Иванов", 
	first_name: "Иван", 
	patronymic: "Иванович", 
	id: 1,
	git: "github.com/ivanov"
})
student.set_contacts({phone_number: "89123456789"})

puts("Информация о студентах:")
puts student.to_s

puts("Короткая информация:")
student1_short = StudentShort.from_student(student)
puts student1_short.to_s

student2_short = StudentShort.from_string(2, "Петров П.В., github.com/petrov, (номер телефона): 89993334455")
puts student2_short.to_s