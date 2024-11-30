require_relative 'person'

class Student < Person
	include Comparable

	attr_reader :second_name, :first_name, :patronymic, :phone_number, :email, :telegram, :birthdate

	PHONE_REGEX = /\A\d{11}\z/
  	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	TELEGRAM_REGEX = /\A[a-zA-Z0-9_]{5,32}\z/
  	FULLNAME_REGEX = /\A[А-Яа-яЁёA-Za-z]+\z/
  	BIRTHDATE_REGEX = /\A(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[0-2])\.(\d{4})\z/

	def initialize(second_name:, first_name:, patronymic:, id: nil,  git: nil, birthdate: nil, phone_number: nil, email: nil, telegram: nil) 
		self.second_name = second_name
		self.first_name = first_name
		self.patronymic = patronymic
		super(id: id, git: git)
		self.birthdate = birthdate
		self.set_contacts(phone_number: phone_number, email: email, telegram: telegram)
	end

	def self.from_hash(hash_params)
		new(
			second_name: hash_params[:second_name],
			first_name: hash_params[:first_name],
			patronymic: hash_params[:patronymic],
			id: hash_params[:id],
			git: hash_params[:git],
			birthdate: hash_params[:birthdate],
			phone_number: hash_params[:phone_number],
			email: hash_params[:email],
			telegram: hash_params[:telegram]
		)
	end

	def set_contacts(phone_number: nil, email: nil, telegram: nil)
		unless phone_number.nil? || Student.valid_phone_number?(phone_number)
      		raise ArgumentError, "Номер телефона некорректный"
    	end
    	@phone_number = phone_number

    	unless email.nil? || Student.valid_email?(email)
      		raise ArgumentError, "Адрес почты некорректный"
   		end
    	@email = email

    	unless telegram.nil? || Student.valid_telegram?(telegram)
      		raise ArgumentError, "Имя пользователя Telegram некорректное"
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

	def self.valid_birthdate?(birthdate)
		birthdate.match?(BIRTHDATE_REGEX)
	end

	def second_name=(second_name)
		unless Student.valid_fullname?(second_name)
			raise ArgumentError, "Фамилия должна быть указана и содержать только буквы"
		end
		@second_name = second_name
	end

	def first_name=(first_name)
		unless Student.valid_fullname?(first_name)
			raise ArgumentError, "Имя должно быть указано и содержать только буквы"
		end
		@first_name = first_name
	end

	def patronymic=(patronymic)
		unless Student.valid_fullname?(patronymic)
			raise ArgumentError, "Отчество должно быть указано и содержать только буквы"
		end
		@patronymic = patronymic
	end

	def birthdate=(birthdate)
		unless Student.valid_birthdate?(birthdate)
			raise ArgumentError, "Дата рождения не соответствует формату (дд.мм.гггг)"
		end
		@birthdate = birthdate
	end

	def contact
    	return "(номер телефона) #{phone_number}" if phone_number
    	return "(почта) #{email}" if email
    	return "(телеграм) #{telegram}" if telegram
	end

	def surname_initials
		"#{second_name} #{first_name[0]}.#{patronymic[0]}."
	end

	def get_info
		"Фамилия И.О.: #{surname_initials}; Git: #{git}, Связь: #{contact}"
	end

	def <=>(other)
    	day1, month1, year1 = @birthdate.split('.').map(&:to_i)
    	day2, month2, year2 = other.birthdate.split('.').map(&:to_i)

    	[year1, month1, day1] <=> [year2, month2, day2]
  	end

	def to_s
		"ФИО: #{second_name} #{first_name} #{patronymic}, ID: #{id},  Git: #{git}, Дата рождения: #{birthdate}, Номер телефона: #{phone_number}, Почта: #{email}, Телеграм: #{telegram}"
	end
end