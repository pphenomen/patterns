class DataList
	private attr_reader :data
	private attr_accessor :selected

	def initialize(data)
		self.data = data
		@selected = []
	end

	private def data=(data)
		raise ArgumentError, "Объект должен являться массивом" unless data.is_a?(Array)
		@data = data
	end

	def select(number)
		raise ArgumentError, "Индекс выходит за пределы" unless number.between?(0, data.length - 1)
		selected << number
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

	def fetch_data
	    check_data
	    process_data
	end

	private

	def check_data
		raise ArgumentError, "Данные отсутствуют" if data.empty?
	end

	def process_data
		raise NotImplementedError, "Метод не реализован в классе"
	end
end