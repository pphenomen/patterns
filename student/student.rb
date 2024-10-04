class Student
	attr_accessor :id, :phone_number, :git
	attr_reader :second_name, :first_name, :patronymic

	def initialize(hash_params = {})
		@second_name = hash_params[:second_name] || raise("Фамилия должна быть указана обязательно")
		@first_name = hash_params[:first_name] || raise("Имя должно быть указано обязательно")
		@patronymic = hash_params[:patronymic] || raise("Отчество должно быть указано обязательно")
		@id = hash_params[:id]
    	self.phone_number = hash_params[:phone_number] if hash_params[:phone_number]
		@git = hash_params[:git]
	end

	def self.valid_phone_number?(phone_number)
		if phone_number =~ (/\A\d{11}\z/)
			true
		else
			false
		end
  	end

  	def phone_number=(phone_number)
    	if !Student.valid_phone_number?(phone_number) 
    		raise "Номер телефона некорректный" 
    	end
    	@phone_number = phone_number
  	end
  	
	def to_s
  		"ФИО: #{second_name} #{first_name} #{patronymic}, ID: #{id || 'не указан'}, Телефон: #{phone_number || 'не указан'}, Git: #{git || 'не указан'}"
	end
end