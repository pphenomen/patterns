require_relative './models/person'
require_relative './models/student'
require_relative './models/student_short'
require_relative './lib/student_binary_tree'
require_relative './lib/data_table'
require_relative './lib/data_list'
require_relative './lib/data_list_student_short'
require_relative './lib/students_list'
require_relative './lib/file_strategy'
require 'json'
require 'yaml'

# tree = StudentBinaryTree.new
# tree.insert(student1)
# tree.insert(student2)
# tree.insert(student3)

# puts "\nОтсортированные даты рождения студентов по возрастанию:"
# tree.each { |student| puts student }

json_strategy = JSONFileStrategy.new
yaml_strategy = YAMLFileStrategy.new

students = StudentsList.new(filepath: './data/students.json', strategy: json_strategy)
students.read_from_file
puts "Список студентов с JSON:"
students.students.each { |student| puts student.to_s }
puts "Студент с id = 3: #{students.get_student_by_id(3)}"
puts "Количество студентов: #{students.get_student_short_count}"

students = StudentsList.new(filepath: './data/students.yaml', strategy: yaml_strategy)
students.read_from_file
puts "Список студентов с YAML:"
students.students.each { |student| puts student.to_s }
puts "Студент с id = 2: #{students.get_student_by_id(2)}"
puts "Количество студентов: #{students.get_student_short_count}"
