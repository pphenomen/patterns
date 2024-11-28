class DataList
	private attr_reader :data

	def initialize(data)
		self.data = data
	end

	private def data=(data)
		unless data.is_a?(Array)
			raise ArgumentError, "Объект должен являться двумерным массивом"
		end
		@data = data.map(&:dup).freeze
	end
end