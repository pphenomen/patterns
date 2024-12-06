require_relative 'file_strategy'

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