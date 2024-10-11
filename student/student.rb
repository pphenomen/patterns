class Person
	attr_reader :id, :git, :phone_number

	def initialize(id: nil, git: nil, phone_number: nil)
		self.id = id if id
    	self.git = git if git
    	self.phone_number = phone_number if phone_number
	end

	def self.valid_id?(id)
		id.is_a?(Integer) && id > 0
	end

	def id=(id)
		unless Person.valid_id?(id)
			raise "ID должно быть целым числом больше нуля"
		end
		@id = id 
	end

	def self.clean_phone_number(phone_number)
    	phone_number.gsub(/\D/, '')
  	end

  	def self.valid_phone_number?(phone_number)
    	cleaned_phone = clean_phone_number(phone_number)
    	cleaned_phone.match?(/\A\d{11}\z/)
  	end

	def phone_number=(phone_number)
    	unless Person.valid_phone_number?(phone_number) 
    		raise "Номер телефона некорректный" 
    	end
    	@phone_number = Person.clean_phone_number(phone_number)
  	end
  	
  	def self.valid_git?(git)
  		git.match?(/\Agithub\.com\/[a-zA-Z0-9_-]+\z/)
  	end

  	def git=(git)
  		unless Person.valid_git?(git)
  			raise "Git некорректный. Пример: github.com/username"
  		end
  		@git = git 
  	end

  	def git_present?
  		!git.nil?
	end

	def contact_present?
		!phone_number.nil?
	end  

	def validate
		unless git_present?
			raise "Git отсутствует"
		end

		unless contact_present?
			raise "Необходимо указать номер телефона для связи"
		end
	end

	def git_link
		git || "Git отсутствует"
	end

	def contact
		if phone_number
    		"(номер телефона): #{phone_number}"
		else 
			"Контакт отсутствует"
		end
	end

	def set_contacts(hash_params={})
		self.phone_number = hash_params[:phone_number]  if hash_params[:phone_number]
	end

	def to_s
		"ID: #{id || 'не указан'}, Телефон: #{phone_number || 'не указан'}, Git: #{git || 'не указан'}"
	end
end

class Student < Person
	attr_reader :second_name, :first_name, :patronymic

	def initialize(hash_params = {})
		self.second_name = hash_params[:second_name] 
		self.first_name = hash_params[:first_name]
		self.patronymic = hash_params[:patronymic]
		super(id: hash_params[:id], git: hash_params[:git], phone_number: hash_params[:phone_number])

	end

	def self.valid_fullname?(fullname)
		!fullname.nil? && fullname.match?(/\A[А-Яа-яЁёA-Za-z]+\z/)
	end

	def second_name=(second_name)
		unless Student.valid_fullname?(second_name)
			raise "Фамилия должна быть указана и содержать только буквы"
		end
		@second_name = second_name
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

	def initials
		"#{second_name} #{first_name[0]}.#{patronymic[0]}."
	end

	def get_info
		"Фамилия И.О.: #{initials}; Git: #{git_link}, Связь#{contact}"
	end

	def to_s
		"ФИО: #{second_name} #{first_name} #{patronymic}, " + super
	end
end

class StudentShort < Person
	attr_reader :surname_initials

	def initialize(id, surname_initials, git, contact)
    	@surname_initials = surname_initials
    	super(id: id, git: git, phone_number: contact)
	end

	def self.from_student(student)
		new(student.id, student.initials, student.git_link, student.contact)
	end

	def self.from_string(id, info_string)
		info = info_string.split(", ")
		surname_initials = info[0]
		git = info[1] || "Git отсутствует"
		contact = info[2] || "Контакт отсутствует"
		new(id, surname_initials, git, contact) 
	end

	def to_s
    	"ID: #{id}, Фамилия И.О.: #{surname_initials}, Git: #{git}, Контакт: #{contact}"
  	end
end	