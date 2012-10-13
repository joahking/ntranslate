class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case user.role
    when "admin"
      can :manage, :all
    when "developer"
      can :manage, TextResource
    end
  end
end
