require_relative './adapter.rb'
require_relative '../lib/students_list.rb'

class StudentsListAdapter < ListAdapter
    def initialize(filepath, strategy)
        @students_list = StudentsList.new(filepath: filepath, strategy: strategy)
    end
  
    def get_student_by_id(id)
        @students_list.get_student_by_id(id)
    end
  
    def get_k_n_student_short_list(k, n)
        @students_list.get_k_n_student_short_list(k, n)
    end
  
    def add_student(student)
        @students_list.add_student(student)
    end
  
    def replace_student_by_id(id, new_student)
        @students_list.replace_student_by_id(id, new_student)
    end
  
    def remove_student_by_id(id)
        @students_list.remove_student_by_id(id)
    end
  
    def get_student_short_count
        @students_list.get_student_short_count
    end
end