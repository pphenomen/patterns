require 'json'
require 'yaml'

class FileStrategy
	def read(filepath)
		raise NotImplementedError, "Метод должен быть реализован в подклассе"
	end

	def write(filepath, data)
		raise NotImplementedError, "Метод должен быть реализован в подклассе"
	end
end
