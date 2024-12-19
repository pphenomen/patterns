require 'fox16'

include Fox

class StudentsApp < FXMainWindow
	def initialize(app)
		super(app, "Students", :width => 1024, :height => 768)

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
	      	choice.appendItem("Не важно")
	      	field = FXTextField.new(field_frame, 25, opts: TEXTFIELD_NORMAL | TEXTFIELD_READONLY)

	      	# enable/disable fields
	      	choice.connect(SEL_COMMAND) do
	        	field.enabled = choice.currentItem == 0
	      	end
	    end

	    # students table
	    table_frame = FXGroupBox.new(student_list_view, "Список студентов", opts: GROUPBOX_NORMAL | LAYOUT_FILL)
	    student_table = FXTable.new(table_frame, opts: LAYOUT_FILL)
	    student_table.setTableSize(5, 5) # rows, columns
	    student_table.setColumnText(0, "ФИО")
	    student_table.setColumnText(1, "Git")
	    student_table.setColumnText(2, "Email")
	    student_table.setColumnText(3, "Телефон")
	    student_table.setColumnText(4, "Telegram")
	    student_table.editable = false

	   	# buttons 
	    control_frame = FXHorizontalFrame.new(student_list_view, opts: LAYOUT_FILL_X)
	    FXButton.new(control_frame, "Добавить", nil, nil, 0, opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
	      	FXMessageBox.information(self, MBOX_OK, "Добавить", "Студент добавлен")
	    end

	    FXButton.new(control_frame, "Удалить", nil, nil, 0, opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
	      	FXMessageBox.warning(self, MBOX_OK, "Удалить", "Студент удален")
	    end

	    # ==2==
	    section2 = FXTabItem.new(sections, "2")
	    FXVerticalFrame.new(sections, opts: LAYOUT_FILL) { FXLabel.new(self, "content 2") }

	    # ==3==
	    section3 = FXTabItem.new(sections, "3")
	    FXVerticalFrame.new(sections, opts: LAYOUT_FILL) { FXLabel.new(self, "content 3") }

		self.connect(SEL_CLOSE) do
			if FXMessageBox.question(self, MBOX_YES_NO, "Закрытие окна", "Вы уверены, что хотите выйти?")
				exit
			end
		end
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