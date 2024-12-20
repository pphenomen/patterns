class Gym
	def initialize
		@subscribers = []
	end

	def add_subscriber(subscriber)
		@subscribers << subscriber
	end

	def remove_subscriber(subscriber)
		@subscribers.delete(subscriber)
	end

	def notify_subscribers(discount)
		@subscribers.each { |subscriber| subscriber.update(discount) }
	end
end

# interface
class Subscriber
	def update(discount)
		raise NotImplementedError, "Метод не реализован в классе"
	end
end

class SMSClient < Subscriber
	def update(discount)
		puts "SMSClient получил уведомление: Скидка: #{discount}"
	end
end

class AppClient < Subscriber
	def update(discount) 
		puts "AppClient получил уведомление: Скидка: #{discount}"
	end
end

gym = Gym.new
sms_client = SMSClient.new
app_client = AppClient.new

gym.add_subscriber(sms_client)
gym.add_subscriber(app_client)

gym.notify_subscribers("30% скидка на годовой абонемент")
gym.remove_subscriber(sms_client)
gym.notify_subscribers("50% скидка на полугодовой абонемент")