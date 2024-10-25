class Person
	attr_reader :id, :git

	GIT_REGEX = /\Ahttps?:\/\/github\.com\/[a-zA-Z0-9_-]+\z/

	def initialize(id: nil, git: nil)
		self.id = id if id
    	self.git = git if git
	end

	private 
	
	# setters 
	def id=(id)
		unless Person.valid_id?(id)
			raise "ID должно быть целым числом больше нуля"
		end
		@id = id 
	end

  	def git=(git)
  		unless Person.valid_git?(git)
  			raise "Git некорректный. Пример: https://github.com/username"
  		end
  		@git = git 
  	end

  	# validators 
	def self.valid_id?(id)
		id.is_a?(Integer) && id > 0
	end

	def self.valid_git?(git)
  		git.match?(GIT_REGEX)
  	end
end