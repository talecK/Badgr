class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Group

    can :create_achievements, Group do |group|
      group.has_admin?(user)
    end

    #can :manage, Achievement do |achievement|
     # achievement.group.has_admin?( user )
    #end

  end
end

