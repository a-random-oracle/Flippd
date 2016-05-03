require_relative '../helpers/event_bus'
require_relative '../event_listeners/karma_listener'

class Flippd < Sinatra::Application
  before do
    @event_bus ||= EventBus.new
    KarmaListener.new(@event_bus)
  end
end
