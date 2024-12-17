require_relative 'file_strategy'

class JSONFileStrategy < FileStrategy
	def read(filepath)
		return [] unless File.exist?(filepath)

    	file = File.read(filepath)
    	data = JSON.parse(file, symbolize_names: true)

        data.map { |student_data| Student.new(**student_data) }
    end

    def write(filepath, data)
        serialized_data = data.map do |student|
            {
                id: student.id,
                second_name: student.second_name,
                first_name: student.first_name,
                patronymic: student.patronymic,
                git: student.git,
                birthdate: student.birthdate,
                phone_number: student.phone_number,
                email: student.email,
                telegram: student.telegram
            }
        end

    	File.open(filepath, 'w') do |file|
            file.write(JSON.pretty_generate(serialized_data))
        end
    end
end
