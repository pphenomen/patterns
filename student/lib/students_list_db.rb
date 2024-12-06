require 'pg'
require_relative '../models/student'
require_relative '../models/student_short'
require_relative 'data_list_student_short'

class StudentsListDB
	attr_reader :connection

	def initialize
		@connection = PG.connect(
			dbname: 'StudentsDB',
			user: 'postgres',
			password: '0311',
			host: 'localhost',
			port: 5432
		)
	end

	def get_student_by_id(id)
		result = connection.exec_params("SELECT * FROM student WHERE id = $1", [id])
		raise ArgumentError, "Студент с ID #{id} не найден" if result.ntuples.zero?
		row = result.first.transform_keys(&:to_sym)
  		Student.from_hash(row)
	end

	def get_k_n_student_short_list(k, n, data_list = nil)
		raise ArgumentError, "Числа должны быть целыми и положительными" unless k.is_a?(Integer) && n.is_a?(Integer) && k > 0 && n > 0

		start = (k - 1) * n
		result = @connection.exec_params('SELECT * FROM student ORDER BY id LIMIT $1 OFFSET $2', [n, start])
		students_short = result.map do |student|
			student = student.transform_keys(&:to_sym)
			StudentShort.from_student(Student.from_hash(student))
	    end
	    data_list ||= DataListStudentShort.new(students_short)
	    data_list
	end

	def add_student(student)
		result = connection.exec_params("INSERT INTO student (second_name, first_name, patronymic, git, birthdate, phone_number, email, telegram)
			VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id", student_fields(student))

		Student.new(
			id: result[0]['id'].to_i,
		    second_name: student.second_name,
		    first_name: student.first_name,
		    patronymic: student.patronymic,
		    git: student.git,
		    birthdate: student.birthdate,
		    phone_number: student.phone_number,
		    email: student.email,
		    telegram: student.telegram
		)
	end

	def replace_student_by_id(id, new_student)
		connection.exec_params("UPDATE student SET second_name = $1, first_name = $2, patronymic = $3, 
			git = $4, birthdate = $5, phone_number = $6, email = $7, telegram = $8 WHERE id = $9",
			student_fields(new_student) + [id]
		)
	end

	def remove_student_by_id(id)
		result = connection.exec_params("DELETE FROM student WHERE id = $1", [id])
		raise ArgumentError, "Студент с ID #{id} не найден" if result.ntuples.zero?
	end

	def get_students_count
    	result = connection.exec("SELECT COUNT(*) AS count FROM student")
    	result[0]['count'].to_i
  	end

  	private

  	def student_fields(student)
    	[
    		student.second_name, student.first_name, student.patronymic, student.git,
    		student.birthdate&.to_s, student.phone_number, student.email, student.telegram
    	]
  	end
end