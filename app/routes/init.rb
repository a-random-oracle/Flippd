require_relative 'auth'
require_relative 'main'
require 'pundit'

class Flippd < Sinatra::Application
  include Pundit
  
  def Pundit.authorize(user, record, query, &block)
    policy = policy!(user, record)
    
    authorized = policy.public_send(query)
    if authorized and block
      yield
    elsif not authorized and not block
      raise NotAuthorizedError.new(query: query, record: record, policy: policy)
    end
    
    true
  end
  
  def authorize(record, query, &block)
    @_pundit_policy_authorized = true
    Pundit.authorize(pundit_user, record, query, &block)
  end

  def pundit_user
    @user
  end
end