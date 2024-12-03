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

class JSONFileStrategy < FileStrategy
	def read(filepath)
		return [] unless File.exist?(filepath)
    	file = File.read(filepath)
    	JSON.parse(file, symbolize_names: true)
    end

    def write(filepath, data)
    	File.write(filepath, JSON.pretty_generate(data))
    end
end

class YAMLFileStrategy < FileStrategy
	def read(filepath)
	    return [] unless File.exist?(filepath)
	    file = File.read(filepath)
	    YAML.safe_load(file, symbolize_names: true, permitted_classes: [Symbol])
	end

	def write(filepath, data)
	    File.write(filepath, YAML.dump(data))
	end
end