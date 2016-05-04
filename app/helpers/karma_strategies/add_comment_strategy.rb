module KarmaStrategies
  class AddCommentStrategy
    STRATEGY_FOR = :add_comment

    def self.award_karma(event)
      event.user.award_karma(KarmaStrategies::get_event_value(event))
    end
  end
end