require './person.rb'
require './student.rb'
require './student_short.rb'

student = Student.new(
  "Иванов", 
  "Иван", 
  "Иванович", 
  id: 1,
  git: "https://github.com/ivanov",
  phone_number: "89123456789",
  email: "ivanov@mail.com",
  telegram: "ivanov123"
)

puts("Информация о студенте:")
puts student.to_s

puts("Корректные данные?")
puts student.validate?

puts("Короткая информация:")
student1_short = StudentShort.from_student(student)
puts student1_short.to_s

student2_short = StudentShort.from_string(2, "Петров П.В., https://github.com/petrov, 89993334455")
puts student2_short.to_s