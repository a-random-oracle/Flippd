require_relative '../helpers/event_bus'
require_relative '../helpers/event_listeners/karma_listener'

class Flippd < Sinatra::Application
  before do
    @event_bus ||= EventBus.new
    @event_bus.attach(KarmaListener.new, [:add_comment, :complete_quiz])
  end
end
