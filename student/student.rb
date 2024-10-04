class Student
	attr_accessor :id, :phone_number, :git
	attr_reader :second_name, :first_name, :patronymic

	def initialize(second_name, first_name, patronymic, id=nil, phone_number=nil, git=nil)
		@second_name = second_name
		@first_name = first_name
		@patronymic = patronymic
		@id = id
		@phone_number = phone_number
		@git = git
	end

	def to_s
  		"ФИО: #{second_name} #{first_name} #{patronymic}, ID: #{id || 'не указан'}, Телефон: #{phone_number || 'не указан'}, Git: #{git || 'не указан'}"
	end

end