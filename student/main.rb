require_relative './models/person'
require_relative './models/student'
require_relative './models/student_short'
require_relative './lib/student_binary_tree'
require_relative './lib/data_table'
require_relative './lib/data_list'
require_relative './lib/data_list_student_short'
require_relative './lib/students_list_json'
require 'json'

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

# student_short1 = StudentShort.from_student(student1)
# student_short2 = StudentShort.from_student(student2)

# data_list = DataListStudentShort.new([student_short1, student_short2])

# puts "До замены данных:"
# puts data_list.get_names.join(", ")
# puts data_list.get_data.inspect

# new_student_short1 = StudentShort.from_student(student3)
# new_student_short2 = StudentShort.from_student(student4)

# new_data_list = DataListStudentShort.new([new_student_short1, new_student_short2])

# puts "\nПосле замены данных:"
# puts data_list.get_names.join(", ")
# puts new_data_list.get_data.inspect

students_list = StudentsListJSON.new(filepath: './data/students.json')

students_list.read_from_file
if students_list.students.nil? || students_list.students.empty?
	puts "Ошибка: данные не загружены или файл пуст."
else
	puts "Данные успешно загружены."
end

if students_list.students.empty?
	puts "Список студентов пуст."
else
	puts "Все студенты:"
	students_list.students.each { |student| puts student.to_s }
end

puts "Список студентов (с 2 по 3):"
student_short_list = students_list.get_k_n_student_short_list(2, 2)

students = student_short_list.get_data 

for i in 0..(students.length - 1)
	puts students[i].to_s
end

students_list.sort_by_surname_initials
puts "Студенты, отсортированные по фамилии и инициалам:"
students_list.students.each { |student| puts student.to_s }

puts "Количество студентов: #{students_list.get_student_short_count}"


def group_by(array)
	result = []

	array.each do |element|
		key = yield(element)
		result[key] = [] if result[key].nil?
		result[key] << element
		end

	result
end 

def reduce(array, initial = nil)
	accumulator = initial.nil? ? array.first : initial
	array.each { |element| accumulator = yield(accumulator, element) }
	accumulator
end