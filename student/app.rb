require 'fox16'

include Fox

class StudentsApp < FXMainWindow
	def initialize(app)
		super(app, "Students", :opts => DECOR_ALL, :width => 1024, :height => 768)

		sections = FXTabBook.new(self, opts: LAYOUT_FILL)

		section1 = FXTabItem.new(sections, "1")
		FXVerticalFrame.new(sections, opts: LAYOUT_FILL) { FXLabel.new(self, "content 1") }

		section2 = FXTabItem.new(sections, "2")
		FXVerticalFrame.new(sections, opts: LAYOUT_FILL) { FXLabel.new(self, "content 2") }

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