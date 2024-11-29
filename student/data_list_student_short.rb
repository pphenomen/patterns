require './data_list.rb'
require './data_table.rb'

class DataListStudentShort < DataList
	def get_names
		["№", "surname_initials", "git", "contact"]
	end

	def get_data
		raise ArgumentError, "Данные отсутствуют" if data.empty?
		data.map.with_index(1) do |object, index|
			[index, object.surname_initials, object.git, object.contact]
		end
	end

	def process_data
    	get_data
  	end
end