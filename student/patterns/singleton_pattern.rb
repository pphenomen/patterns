class CoffeeShop
	@instance = nil 

	def self.instance
		@instance ||= new
	end

	private_class_method :new

	def initialize
		@total_coffees_made = 0
	end

	def make_coffee
		@total_coffees_made += 1
		puts "Кофе сварен. Общее количество: #{total_coffees_made}"
	end

	def total_coffees_made
		@total_coffees_made
	end
end

# Получение единственного экземпляра CoffeeShopManager
barista1 = CoffeeShop.instance
barista2 = CoffeeShop.instance

puts "Оба объекта указывают на один и тот же экземпляр? #{barista1.equal?(barista2)}" 

puts "Приготовление кофе через 1 менеджера..."
barista1.make_coffee
barista1.make_coffee

puts "Проверка количества кофе через 2 менеджера"
puts "Кофе приготовлено всего: #{barista2.total_coffees_made}"

puts "Приготовление кофе через 2 менеджера..."
barista2.make_coffee

puts "Проверка количества кофе снова через 1 менеджера"
puts "Кофе приготовлено всего: #{barista1.total_coffees_made}"