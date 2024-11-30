require 'json'
require_relative '../models/student'
require_relative 'data_list'

class StudentsListJSON
	attr_accessor :filepath 
	attr_reader :students

	def initialize(filepath:, students: nil)
	    self.filepath = filepath
	    @students = students
	end

	def students=(students)
	    unless students.nil? || students.is_a?(Array) 
	    	raise ArgumentError, "Неверный тип данных"
	    end
	    @students = students
	end

	def read_from_file
	  	if File.exist?(self.filepath)
		    file = File.read(self.filepath)
		    student_data = JSON.parse(file, symbolize_names: true)
		    @students = student_data.map { |data| Student.new(**data) }
	  	else
	    	@students = []
	  	end
	end

	def write_to_file
		data = @students.map { |student| {
			id: student.id,
		    second_name: student.second_name,
		    first_name: student.first_name,
		    patronymic: student.patronymic,
		    git: student.git,
		    birthdate: student.birthdate,
		    phone_number: student.phone_number,
		    email: student.email,
		    telegram: student.telegram
		}}
		File.write(filepath, JSON.pretty_generate(data))
	end

	def get_student_by_id(id)
		student = @students.find { |student| student.id == id }
		raise ArgumentError, "Студент с ID #{id} не найден" if student.nil?
		student
	end

	def get_k_n_student_short_list(k, n, data_list = nil)
		if k <= 0 || n <= 0
		    raise ArgumentError, "Числа должны быть положительными"
		end
		start = (k - 1) * n
        selected = self.students[start, n] || []
        students_short = self.students[start, n].map { |student| StudentShort.from_student(student) }
        data_list ||= DataListStudentShort.new(selected)
        data_list
  	end

  	def sort_by_surname_initials
		@students.sort_by! { |student| student.surname_initials }
	end

	def add_student(student)
		new_id = @students.empty? ? 1 : @students.map(&:id).max + 1
	    student_with_new_id = Student.new(
		    second_name: student.second_name,
		    first_name: student.first_name,
		    patronymic: student.patronymic,
		    id: new_id,
		    git: student.git,
		    birthdate: student.birthdate,
		    phone_number: student.phone_number,
		    email: student.email,
		    telegram: student.telegram
		)
		@students << student_with_new_id
	end

	def replace_student_by_id(id, new_student)
	    index = @students.find_index { |student| student.id == id }
	    raise IndexError, 'Студента с таким id нет' unless index
		new_student.id = id
		@students[index] = new_student
		write_to_file
	end

	def remove_student_by_id(id)
		@students.reject! { |student| student.id == id }
		write_to_file
	end

	def get_student_short_count
		@students.count
	end
end
