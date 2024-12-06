require 'pg'

class DBConfig

	DEFAULT_CONFIG = {
	    dbname: 'StudentsDB',
	    user: 'postgres',
	    password: '0311',
	    host: 'localhost',
	    port: 5432
  	}.freeze

	private attr_reader :connection

	def initialize
		@connection = PG.connect(DEFAULT_CONFIG)
	end

	def execute_query(query, params = [])
	    connection.exec_params(query, params)
	end

	def close
		connection.close
	end
end