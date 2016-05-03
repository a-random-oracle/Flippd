class Event
  attr_reader :type, :user, :details

  def initialize(type, user, details={})
    @type = type
    @user = user
    @details = details
  end
end