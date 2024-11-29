require './person.rb'

class StudentShort < Person
	attr_reader :surname_initials, :contact
	 private_class_method :new

	def initialize(surname_initials, id:nil, git:nil, contact:nil)
    	@surname_initials = surname_initials
    	@contact = contact
    	super(id: id, git: git)
	end

	def self.from_student(student)
		new(student.surname_initials, id: student.id, git: student.git, contact: student.contact)
	end

	def self.from_string(id, info_string)
		info = info_string.split(", ")
		surname_initials = info[0]
		git = info[1] 
		contact = info[2]
		new(surname_initials, id: id, git: git, contact: contact)
	end

	def to_s
    	"ID: #{id}, Фамилия И.О.: #{surname_initials}, Git: #{git}, Контактная информация: #{contact}"
  	end
end	