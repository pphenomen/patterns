require './person.rb'
require './student.rb'
require './student_short.rb'
require './student_binary_tree.rb'
require './data_table.rb'
require './data_list.rb'
require './data_list_student_short.rb'

student1 = Student.new(
	second_name: "Иванов", 
	first_name: "Иван", 
	patronymic: "Иванович", 
	id: 1,
	git: "https://github.com/ivanov",
	birthdate: "01.11.2002",
	phone_number: "89123456789",
	email: "ivanov@mail.com",
	telegram: "ivanov123"
)

student2 = Student.new(
	second_name: "Петров", 
	first_name: "Петр", 
	patronymic: "Петрович", 
	id: 2,
	git: "https://github.com/petrov",
	birthdate: "24.06.2004",
	phone_number: "89987654321",
	email: "petrov@mail.com",
	telegram: "petrov123"
)

student3 = Student.new(
	second_name: "Васильев", 
	first_name: "Василий", 
	patronymic: "Васильевич", 
	id: 3,
	git: nil,
	birthdate: "12.03.2002",
	phone_number: nil,
	email: nil,
	telegram: nil
)

student4 = Student.new(
	second_name: "Григорьев", 
	first_name: "Григорий", 
	patronymic: "Григорьевич", 
	id: 4,
	git: "https://github.com/grisha",
	birthdate: "19.04.2004",
	phone_number: nil,
	email: "grisha@mail.ru",
	telegram: nil
)

# puts("Информация о студентах:")
# puts student1
# puts student2
# puts student3

# puts("Корректные данные?")
# puts student1.validate?
# puts student2.validate?
# puts student3.validate?

# puts("Короткая информация о студенте 1:")
# student1_short = StudentShort.from_student(student1)
# puts student1_short

# puts("Короткая информация о студенте 2 из строки:")
# student2_short = StudentShort.from_string(2, "Петров П.В., https://github.com/petrov, 89993334455") 
# puts student2_short

# tree = StudentBinaryTree.new
# tree.insert(student1)
# tree.insert(student2)
# tree.insert(student3)

# puts "\nОтсортированные даты рождения студентов по возрастанию:"
# tree.each { |student| puts student }

# testdata = DataTable.new([[1,2,3],[4,5,6]])

# puts testdata.inspect
# puts testdata.rows_count
# puts testdata.columns_count
# puts testdata.get_element(1,2)

# list = DataList.new([10, 20, 30])
# puts list.inspect 
# list.select(1)
# list.select(2)
# puts list.get_selected 

student_short1 = StudentShort.from_student(student1)
student_short2 = StudentShort.from_student(student2)

data_list = DataListStudentShort.new([student_short1, student_short2])

puts "До замены данных:"
puts data_list.get_names.join(", ")
puts data_list.fetch_data.inspect

new_student_short1 = StudentShort.from_student(student3)
new_student_short2 = StudentShort.from_student(student4)

new_data_list = DataListStudentShort.new([new_student_short1, new_student_short2])

puts "\nПосле замены данных:"
puts data_list.get_names.join(", ")
puts new_data_list.fetch_data.inspect