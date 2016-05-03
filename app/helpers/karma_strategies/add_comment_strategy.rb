require_relative '../event'

module KarmaStrategies
  class AddCommentStrategy
    STRATEGY_FOR = :add_comment

    def self.award_karma(event)
      event.user.award_karma(17)
    end
  end
end