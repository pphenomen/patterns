require 'yaml'
require_relative '../models/student'
require_relative '../models/student_short'
require_relative 'data_list'
require_relative 'students_list_base'

class StudentsListYAML < StudentsListBase
	def read_from_file
	  	if File.exist?(self.filepath)
		    file = File.read(self.filepath)
		    student_data = YAML.safe_load(file, symbolize_names: true)
		    self.students = student_data.map { |data| Student.new(**data) }
	  	else
	    	self.students = []
	  	end
	end

	def write_to_file
		data = self.students.map { |student| {
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
		File.write(filepath, YAML.dump(data))
	end
end
