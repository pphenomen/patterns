class Student
	attr_accessor :id, :phone_number, :git
	attr_reader :second_name, :first_name, :patronymic

	def initialize(hash_params = {})
		self.second_name = hash_params[:second_name] 
		self.first_name = hash_params[:first_name]
		self.patronymic = hash_params[:patronymic]
		self.id = hash_params[:id] if hash_params[:id]
    	self.phone_number = hash_params[:phone_number]  if hash_params[:phone_number]
		self.git = hash_params[:git] if hash_params[:git]
	end

	def self.valid_fullname?(fullname)
		!fullname.nil? && fullname.match?(/\A[А-Яа-яЁёA-Za-z]+\z/)
	end

	def second_name=(second_name)
		unless Student.valid_fullname?(second_name)
			raise "Фамилия должна быть указана и содержать только буквы"
		end
	end

	def first_name=(first_name)
		unless Student.valid_fullname?(first_name)
			raise "Имя должно быть указано и содержать только буквы"
		end
		@first_name = first_name
	end

	def patronymic=(patronymic)
		unless Student.valid_fullname?(patronymic)
			raise "Отчество должно быть указано и содержать только буквы"
		end
		@patronymic = patronymic
	end

	def self.valid_id?(id)
		id.is_a?(Integer) && id > 0
	end

	def id=(id)
		unless Student.valid_id?(id)
			raise "ID должно быть целым числом больше нуля"
		end
		@id = id 
	end

	def self.valid_phone_number?(phone_number)
		if phone_number =~ (/\A\d{11}\z/)
			true
		else
			false
		end
  	end

  	def phone_number=(phone_number)
    	unless Student.valid_phone_number?(phone_number) 
    		raise "Номер телефона некорректный" 
    	end
    	@phone_number = phone_number
  	end
  	
  	def self.valid_git?(git)
  		git.match?(/\Agithub\.com\/[a-zA-Z0-9_-]+\z/)
  	end

  	def git=(git)
  		unless Student.valid_git?(git)
  			raise "Git некорректный. Пример: https://github.com/username"
  		end
  		@git = git 
  	end

	def to_s
  		"ФИО: #{second_name} #{first_name} #{patronymic}, ID: #{id || 'не указан'}, Телефон: #{phone_number || 'не указан'}, Git: #{git || 'не указан'}"
	end
end