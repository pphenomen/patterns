require_relative '../models/student'
require_relative '../models/student_short'
require_relative 'data_list'
require_relative '../strategy/json_file_strategy'
require_relative '../strategy/yaml_file_strategy'

class StudentsList
  attr_accessor :filepath, :strategy
  attr_reader :students

  def initialize(filepath:, strategy:, students: nil)
      self.filepath = filepath
      self.strategy = strategy
      self.students = students || read_from_file
  end

  def students=(students)
      unless students.nil? || students.is_a?(Array) 
        raise ArgumentError, "Неверный тип данных"
      end
      @students = students
  end

  def read_from_file
    data = strategy.read(filepath)
    data.map { |student_data| Student.new(**student_data) }
  end

  def write_to_file
    data = students.map do |student|
      {
        id: student.id,
        second_name: student.second_name,
        first_name: student.first_name,
        patronymic: student.patronymic,
        git: student.git,
        birthdate: student.birthdate,
        phone_number: student.phone_number,
        email: student.email,
        telegram: student.telegram
      }
    end
    strategy.write(filepath, data)
  end

  def get_student_by_id(id)
    student = self.students.find { |student| student.id == id }
    raise ArgumentError, "Студент с ID #{id} не найден" if student.nil?
    student
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    if k <= 0 || n <= 0 || !k.is_a?(Integer) || !n.is_a?(Integer)
        raise ArgumentError, "Числа должны быть целыми и положительными"
    end
    start = (k - 1) * n
    selected = self.students[start, n] || []
    students_short = self.students[start, n].map { |student| StudentShort.from_student(student) }
    data_list ||= DataListStudentShort.new(selected)
    data_list
  end

  def sort_by_surname_initials
    self.students.sort_by! { |student| student.surname_initials }
  end

  def add_student(student)
      new_id = self.students.empty? ? 1 : @students.map(&:id).max + 1
      student_with_new_id = Student.new(
        second_name: student.second_name,
        first_name: student.first_name,
        patronymic: student.patronymic,
        id: new_id,
        git: student.git,
        birthdate: student.birthdate,
        phone_number: student.phone_number,
        email: student.email,
        telegram: student.telegram
    )
    self.students << student_with_new_id
    write_to_file
  end

  def replace_student_by_id(id, new_student)
    index = self.students.find_index { |student| student.id == id }
    raise IndexError, 'Студента с таким id нет' unless index
    new_student.id = id
    self.students[index] = new_student
    write_to_file
  end

  def remove_student_by_id(id)
    self.students.reject! { |student| student.id == id }
    write_to_file
  end

  def get_student_short_count
    self.students.count
  end
end
