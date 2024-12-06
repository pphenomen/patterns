require_relative './models/person'
require_relative './models/student'
require_relative './models/student_short'
require_relative './lib/student_binary_tree'
require_relative './lib/data_table'
require_relative './lib/data_list'
require_relative './lib/data_list_student_short'
require_relative './lib/students_list'
require_relative './lib/file_strategy'
require_relative './lib/students_list_db'
require_relative './lib/dbconfig'
require 'json'
require 'yaml'

# student1 = Student.new(
#   second_name: 'Иванов',
#   first_name: 'Иван',
#   patronymic: 'Иванович',
#   birthdate: '1995-05-06',
#   phone_number: '89161234567',
#   email: 'ivanov@example.com',
#   telegram: 'ivanov_ivan',
#   git: 'https://github.com/ivanov'
# )

# student2 = Student.new(
#   second_name: 'Петров',
#   first_name: 'Петр',
#   patronymic: 'Петрович',
#   birthdate: '1998-10-02',
#   phone_number: '89162223344',
#   email: 'petrov@example.com',
#   telegram: 'petrov_petr',
#   git: 'https://github.com/petrov'
# )

# student3 = Student.new(
#   second_name: 'Смирнова',
#   first_name: 'Мария',
#   patronymic: 'Ивановна',
#   birthdate: '1997-03-09',
#   phone_number: '89164445566',
#   email: 'smirnova@example.com',
#   telegram: 'smirnova_maria',
#   git: 'https://github.com/smirnova'
# )

# tree = StudentBinaryTree.new
# tree.insert(student1)
# tree.insert(student2)
# tree.insert(student3)

# puts "\nОтсортированные даты рождения студентов по возрастанию:"
# tree.each { |student| puts student }


# json_strategy = JSONFileStrategy.new
# yaml_strategy = YAMLFileStrategy.new

# students = StudentsList.new(filepath: './data/students.json', strategy: json_strategy)
# students.read_from_file
# puts "Список студентов с JSON:"
# students.students.each { |student| puts student.to_s }
# puts "Студент с id = 3: #{students.get_student_by_id(3)}"
# puts "Количество студентов: #{students.get_student_short_count}"

# students = StudentsList.new(filepath: './data/students.yaml', strategy: yaml_strategy)
# students.read_from_file
# puts "Список студентов с YAML:"
# students.students.each { |student| puts student.to_s }
# puts "Студент с id = 2: #{students.get_student_by_id(2)}"
# puts "Количество студентов: #{students.get_student_short_count}"

db = DBConfig.instance

result = db.execute_query("SELECT * FROM student WHERE id = $1", [3])

result.each do |row|
  puts row
end

# Получение второго экземпляра (тот же объект)
db2 = DBConfig.instance
puts db.equal?(db2) # true

db.close