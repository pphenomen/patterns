require_relative 'file_strategy'

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
