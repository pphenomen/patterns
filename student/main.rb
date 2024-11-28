require './person.rb'
require './student.rb'
require './student_short.rb'
require './student_binary_tree.rb'
require './data_table.rb'
require './data_list.rb'

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
	id: 3,
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
	id: 4,
	git: "https://github.com/vasilyev",
	birthdate: "12.03.2002",
	phone_number: "89287653494",
	email: "vasilyev@mail.com",
	telegram: "vasilyev123"
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

list = DataList.new([10, 20, 30])
puts list.inspect 
list.select(1)
list.select(2)
puts list.get_selected 