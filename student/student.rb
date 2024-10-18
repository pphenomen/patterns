require './person.rb'

class Student < Person
	attr_reader :second_name, :first_name, :patronymic, :phone_number, :email, :telegram

	PHONE_REGEX = /\A\d{11}\z/
  	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	TELEGRAM_REGEX = /\A[a-zA-Z0-9_]{5,32}\z/
  	FULLNAME_REGEX = /\A[А-Яа-яЁёA-Za-z]+\z/

	def initialize(second_name, first_name, patronymic, hash_params = {id: nil, git: nil, phone_number: nil, email: nil, telegram: nil})
		self.second_name = second_name
		self.first_name = first_name
		self.patronymic = patronymic
		super(id: hash_params[:id], git: hash_params[:git])
		self.set_contacts(phone_number: hash_params[:phone_number], email: hash_params[:email], telegram: hash_params[:telegram])
	end

	def set_contacts(phone_number: nil, email: nil, telegram: nil)
		unless phone_number.nil? || Student.valid_phone_number?(phone_number)
      		raise "Номер телефона некорректный"
    	end
    	@phone_number = phone_number

    	unless email.nil? || Student.valid_email?(email)
      		raise "Адрес почты некорректный"
   		end
    	@email = email

    	unless telegram.nil? || Student.valid_telegram?(telegram)
      		raise "Имя пользователя Telegram некорректное"
    	end
    	@telegram = telegram
	end

	def self.valid_phone_number?(phone_number)
  		phone_number.match?(PHONE_REGEX)
  	end

  	def self.valid_email?(email)
  		email.match?(EMAIL_REGEX)
  	end

  	def self.valid_telegram?(telegram)
  		telegram.match?(TELEGRAM_REGEX)
  	end

	def self.valid_fullname?(fullname)
		!fullname.nil? && fullname.match?(FULLNAME_REGEX)
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

  	def git_present?
  		!git.nil?
	end

	def contact_present?
		!phone_number.nil? || !email.nil? || !telegram.nil?
	end  

	def validate?
		git_present? && contact_present?
	end

	def contact
		contacts = []
    	contacts << "номер телефона: #{phone_number}" if phone_number
    	contacts << "почта: #{email}" if email
    	contacts << "телеграм: #{telegram}" if telegram
    	contacts.empty? ? "Нет контактной информации" : contacts.join(", ")
	end

	def initials
		"#{second_name} #{first_name[0]}.#{patronymic[0]}."
	end

	def get_info
		"Фамилия И.О.: #{initials}; Git: #{git}, Связь: #{contact}"
	end

	def to_s
		"ФИО: #{second_name} #{first_name} #{patronymic}, ID: #{id}, Git: #{git}, Контактная информация: #{contact}"
	end
end

