require_relative './adapter.rb'
require_relative '../db/students_list_db.rb'

class StudentsListDBAdapter < ListAdapter
    def initialize(db_connection)
      	@students_list_db = StudentsListDB.instance(db_connection)
    end
  
    def get_student_by_id(id)
      	@students_list_db.get_student_by_id(id)
    end
  
    def get_k_n_student_short_list(k, n)
      	@students_list_db.get_k_n_student_short_list(k, n)
    end
  
    def add_student(student)
      	@students_list_db.add_student(student)
    end
  
    def replace_student_by_id(id, new_student)
      	@students_list_db.replace_student_by_id(id, new_student)
    end
  
    def remove_student_by_id(id)
      	@students_list_db.remove_student_by_id(id)
    end
  
    def get_student_short_count
      	@students_list_db.get_student_short_count
    end
end