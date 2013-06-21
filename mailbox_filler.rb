require 'celluloid/autostart'

class PublisherThingie
  include Celluloid
  include Celluloid::Notifications

  def commence_sadness
    loop do
      publish("some_topic", "a message")
    end
  end

end

class SubscriberThingie
  include Celluloid
  include Celluloid::Notifications

  def initialize
    subscribe("some_topic", :long_running_method)
  end

  def long_running_method(topic, message)
    sleep 100000000
  end

end

subscriber = SubscriberThingie.new

publisher = PublisherThingie.new
publisher.commence_sadness
