class DataTable
	private attr_reader :data

	def initialize(data)
		self.data = data
	end 

	private def data=(data)
		unless data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
			raise ArgumentError, "Объект должен являться двумерным массивом"
		end
		@data = data
	end

	def rows_count
		data.size
	end

	def columns_count
		data[0].size
	end

	def get_element(row,col)
		raise IndexError, "Неверный индекс строки" if row < 0 || row >= rows_count
		raise IndexError, "Неверный индекс столбца" if col < 0 || col >= columns_count

		data[row][col]
	end
end