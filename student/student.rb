class Student
	def initialize(second_name, first_name, patronymic, id=nil, phone_number=nil, git=nil)
		@second_name = second_name
		@first_name = first_name
		@patronymic = patronymic
		@id = id
		@phone_number = phone_number
		@git = git
	end

	def second_name
		@second_name
	end

	def second_name=(new_second_name)
		@second_name = new_second_name
	end

	def first_name
		@first_name
	end

	def first_name=(new_first_name)
		@first_name = new_second_name
	end

	def patronymic
		@patronymic
	end

	def patronymic=(new_patronymic)
		@patronymic = new_patronymic
	end

	def id
		@id
	end
	
	def id=(new_id)
		@id = new_id
	end

	def phone_number
		@phone_number
	end

	def phone_number=(new_phone_number)
		@phone_number = new_phone_number
	end

	def git
		@git
	end

	def git=(new_git)
		@git = new_git
	end

	def to_s
  		"ФИО: #{second_name} #{first_name} #{patronymic}, ID: #{id || 'не указан'}, Телефон: #{phone_number || 'не указан'}, Git: #{git || 'не указан'}"
	end


end