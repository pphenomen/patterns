class DataList
	private attr_reader :data
	private attr_accessor :selected

	def initialize(data)
		self.data = data
		@selected = []
	end

	private def data=(data)
		unless data.is_a?(Array)
			raise ArgumentError, "Объект должен являться двумерным массивом"
		end
		@data = data
	end

	def select(number)
		if number.between?(0, data.length - 1)
			selected << number
		end
	end

	def get_selected
		selected
	end

	def get_names
		raise NotImplementedError, "Метод не реализован в классе"
	end

	def get_data
		raise NotImplementedError, "Метод не реализован в классе"
	end
end