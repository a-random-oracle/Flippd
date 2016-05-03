require_relative '../helpers/event_bus'

class Flippd < Sinatra::Application
  before do
    @event_bus ||= EventBus.new
  end
end
