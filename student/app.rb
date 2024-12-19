require 'fox16'

include Fox

class StudentsApp < FXMainWindow
	def initialize(app)
		super(app, "Students", :width => 1024, :height => 768)

		@students_per_page = 20
    	@current_page = 1
    	@data = generate_data(60)

		sections = FXTabBook.new(self, opts: LAYOUT_FILL)

		# ==1==
		section1 = FXTabItem.new(sections, "Список студентов")
		student_list_view = FXVerticalFrame.new(sections, opts: LAYOUT_FILL)

		# filter
		filter_frame = FXGroupBox.new(student_list_view, "Фильтрация", opts: GROUPBOX_NORMAL | LAYOUT_FILL_X)
		FXLabel.new(filter_frame, "ФИО:")
		fio_field = FXTextField.new(filter_frame, 25)

		%w[Git Почта Телефон Telegram].each do |field_name|
			field_frame = FXHorizontalFrame.new(filter_frame, opts: LAYOUT_FILL_X)
			FXLabel.new(field_frame, "#{field_name}:")
	      	choice = FXComboBox.new(field_frame, 15, opts: COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK)
	      	choice.numVisible = 3
	      	choice.appendItem("Да")
	      	choice.appendItem("Нет")
	      	choice.appendItem("Неважно")
	      	field = FXTextField.new(field_frame, 25, opts: TEXTFIELD_NORMAL | TEXTFIELD_READONLY)

	      	# enable/disable fields
	      	choice.connect(SEL_COMMAND) do
	        	field.enabled = choice.currentItem == 0
	      	end
	    end

	    # students table
	    table_frame = FXGroupBox.new(student_list_view, "Список студентов", opts: GROUPBOX_NORMAL | LAYOUT_FILL)
	    @student_table = FXTable.new(table_frame, opts: LAYOUT_FILL)
	    @student_table.setTableSize(5, 5) # rows, columns
	    @student_table.setColumnText(0, "ФИО")
	    @student_table.setColumnText(1, "Git")
	    @student_table.setColumnText(2, "Email")
	    @student_table.setColumnText(3, "Телефон")
	    @student_table.setColumnText(4, "Telegram")
	    @student_table.editable = false

	    # hardcode >:)
	    data = [
	      	["Иванов И.И.", "https://github.com/ivanov", "ivanov@example.com", "89123456789", "ivanov"],
	      	["Петров П.П.", "https://github.com/petrov", "petrov@example.com", "89234567890", "petrov"],
	      	["Сидоров С.С.", "", "sidorov@example.com", "89345678901", ""],
	      	["Кузнецов К.К.", "https://github.com/kuznetsov", "", "89456789012", "kuznetsov"],
	      	["Смирнов С.С.", "https://github.com/smirnov", "smirnov@example.com", "", "smirnov"]
	    ]

	    # insert data
	    data.each_with_index do |row, i|
	      	row.each_with_index do |value, j|
	       		@student_table.setItemText(i, j, value)
	      	end
	    end

	   	# add/del buttons 
	    control_frame = FXHorizontalFrame.new(student_list_view, opts: LAYOUT_FILL_X)
	    FXButton.new(control_frame, "Добавить", nil, nil, 0, opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
	      	FXMessageBox.information(self, MBOX_OK, "Добавить", "Студент добавлен")
	    end

	    FXButton.new(control_frame, "Удалить", nil, nil, 0, opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
	      	FXMessageBox.warning(self, MBOX_OK, "Удалить", "Студент удален")
	    end

	    # pagination buttons 
	    pagination_frame = FXHorizontalFrame.new(student_list_view, opts: LAYOUT_FILL_X)
	    @page_label = FXLabel.new(pagination_frame, "Страница 1 из #{total_pages}", opts: LAYOUT_CENTER_X)

	    FXButton.new(pagination_frame, "Назад", nil, nil, 0, opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
	      	if @current_page > 1
	        	@current_page -= 1
	        	update_table
	      	end
	    end

	    FXButton.new(pagination_frame, "Вперед", nil, nil, 0, opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
	      	if @current_page < total_pages
	        	@current_page += 1
	        	update_table
	      	end
	    end

	    update_table

	    # ==2==
	    # section2 = FXTabItem.new(sections, "2")
	    # FXVerticalFrame.new(sections, opts: LAYOUT_FILL) { FXLabel.new(self, "content 2") }

	    # ==3==
	    # section3 = FXTabItem.new(sections, "3")
	    # FXVerticalFrame.new(sections, opts: LAYOUT_FILL) { FXLabel.new(self, "content 3") }

		self.connect(SEL_CLOSE) do
			if FXMessageBox.question(self, MBOX_YES_NO, "Закрытие окна", "Вы уверены, что хотите выйти?")
				exit
			end
		end
	end

	def generate_data(count)
    	(1..count).map do |i|
      		["ФИО #{i}", "https://github.com/user#{i}", "user#{i}@example.com", "89#{i.to_s.rjust(8, '0')}", "telegram#{i}"]
    	end
  	end

	def update_table
	    start_index = (@current_page - 1) * @students_per_page
	    end_index = [start_index + @students_per_page, @data.size].min
	    page_data = @data[start_index...end_index]

	    @student_table.setTableSize(page_data.size, 5)

	    page_data.each_with_index do |row, i|
	      	row.each_with_index do |value, j|
	        	@student_table.setItemText(i, j, value.to_s)
	      	end
	    end

	    @page_label.text = "Страница #{@current_page} из #{total_pages}"
  	end

	def total_pages
    	(@data.size.to_f / @students_per_page).ceil
  	end

	def create
		super
		show(PLACEMENT_SCREEN)
	end
end

if __FILE__ == $0
	app = FXApp.new
	StudentsApp.new(app)
	app.create
	app.run
end