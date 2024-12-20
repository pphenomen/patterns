require 'fox16'

include Fox

class StudentsApp < FXMainWindow
	def initialize(app)
		super(app, "Students", :width => 1024, :height => 768)

		@students_per_page = 20
    	@current_page = 1
    	@original_data = generate_data(60)
    	@data = @original_data.dup

		sections = FXTabBook.new(self, opts: LAYOUT_FILL)

		# ==1==
		section1 = FXTabItem.new(sections, "Список студентов")
		student_list_view = FXVerticalFrame.new(sections, opts: LAYOUT_FILL)

		# filter
		filter_frame = FXGroupBox.new(student_list_view, "Фильтрация", opts: GROUPBOX_NORMAL | LAYOUT_FILL_X)
		FXLabel.new(filter_frame, "ФИО:")
		@fio_field = FXTextField.new(filter_frame, 25)
		@filters = {}

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
	        	field.enabled = (choice.currentItem == 0)
	        	field.text = "" if choice.currentItem != 0
	      	end

	      	@filters[field_name] = { choice: choice, field: field }
	    end

	    # students table
	    table_frame = FXGroupBox.new(student_list_view, "Список студентов", opts: GROUPBOX_NORMAL | LAYOUT_FILL)
	    @table = FXTable.new(table_frame, opts: LAYOUT_FILL)
	    @table.setTableSize(20, 5) # rows, columns
	    @table.setColumnText(0, "ФИО")
	    @table.setColumnText(1, "Git")
	    @table.setColumnText(2, "Email")
	    @table.setColumnText(3, "Телефон")
	    @table.setColumnText(4, "Telegram")
	    @table.editable = false

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

	    @table.connect(SEL_COMMAND) do |sender, sel, event|
	  		if event.row == -1
	   			col = event.col
	    		# fio
	    		if col == 0
			      	@data.sort_by! { |row| row[0] }
	      			update_table
    			end
  			end
		end

	    control_frame = FXHorizontalFrame.new(student_list_view, opts: LAYOUT_FILL_X)

	    @add_button = FXButton.new(control_frame, "Добавить", opts: BUTTON_NORMAL)
	    @add_button.connect(SEL_COMMAND) do
	      	FXMessageBox.information(self, MBOX_OK, "Добавить", "Добавление студента")
	    end

	    @edit_button = FXButton.new(control_frame, "Изменить", opts: BUTTON_NORMAL)
	    @edit_button.connect(SEL_COMMAND) do
	      	selected_row = get_selected_rows.first
	      	FXMessageBox.information(self, MBOX_OK, "Изменить", "Изменение студента в строке #{selected_row + 1}")
	    end

	    @delete_button = FXButton.new(control_frame, "Удалить", opts: BUTTON_NORMAL)
	    @delete_button.connect(SEL_COMMAND) do
	      	selected_rows = get_selected_rows
	      	FXMessageBox.warning(self, MBOX_OK, "Удалить", "Удаление строк: #{selected_rows.map { |r| r + 1 }.join(', ')}")
	    end

	    @refresh_button = FXButton.new(control_frame, "Обновить", opts: BUTTON_NORMAL)
	    @refresh_button.connect(SEL_COMMAND) do
	    	apply_filters
	      	FXMessageBox.information(self, MBOX_OK, "Обновить", "Данные обновлены")
	    end

	    @table.connect(SEL_CHANGED) { update_button_states }

	    update_button_states

		self.connect(SEL_CLOSE) do
			if FXMessageBox.question(self, MBOX_YES_NO, "Закрытие окна", "Вы уверены, что хотите выйти?")
				exit
			end
		end
	end

	def apply_filters
	    @data = @original_data.dup

	    fio_value = @fio_field.text.strip
	    unless fio_value.empty?
	      	@data.select! { |row| row[0].include?(fio_value) }
	    end

	    column_map = {
	     	"Git" => 1,
	      	"Почта" => 2,
	      	"Телефон" => 3,
	      	"Telegram" => 4
	    }

	    @filters.each do |fname, data|
	      	choice_val = data[:choice].currentItem
	      	text_val = data[:field].text.strip
	      	col_index = column_map[fname]

		    # choice_val:
		    # 0 - да: фильтровать только строки, где есть совпадение text_val в данном поле
		    # 1 - нет: фильтровать строки, где соответствующее поле пусто или не содержит данных
		    # 2 - неважно: не фильтруем по этому полю

	      	case choice_val
	      	when 0
	        	next if text_val.empty?
	        	@data.select! { |row| row[col_index].to_s.include?(text_val) }
	      	when 1
	        	if text_val.empty?
	          		@data.select! { |row| row[col_index].to_s.strip.empty? }
	        	else
	          		@data.select! { |row| !row[col_index].to_s.include?(text_val) }
        		end
      		when 2
        		# ничего не делаем
      		end
    	end

    	@current_page = 1
    	update_table
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

	    @table.setTableSize(page_data.size, 5)

	    page_data.each_with_index do |row, i|
	      	row.each_with_index do |value, j|
	        	@table.setItemText(i, j, value.to_s)
	      	end
	    end

	    @page_label.text = "Страница #{@current_page} из #{total_pages}"
  	end

	def total_pages
    	(@data.size.to_f / @students_per_page).ceil
  	end

  	def get_selected_rows
    	(0...@table.numRows).select { |i| @table.rowSelected?(i) }
  	end

  	def update_button_states
	  	selected_rows = get_selected_rows
	  	case selected_rows.size
	  	when 0
	    	@edit_button.disable
	    	@delete_button.disable
	  	when 1
	    	@edit_button.enable
	    	@delete_button.enable
	  	else
	    	@edit_button.disable
	    	@delete_button.enable
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