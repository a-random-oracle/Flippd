class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false # Default is to deny create requests
  end

  def new?
    create? # Alias new => create
  end

  def update?
    false # Default is to deny update requests
  end

  def edit?
    update? # Alias edit => update
  end

  def destroy?
    false # Default is to deny destroy requests
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end