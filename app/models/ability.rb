class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can [:read, :create], Group
    can :read, User

    can :create_achievements, Group do |group|
      group.has_admin?(user)
    end

    can :update, Group do |group|
      group.has_admin?(user)
    end

    can :manage, User do |curr_profile|
      user == curr_profile
    end

    #can manage all if user is super_admin
    can :manage, :all if user.role == User::ROLES[0]

    #can :manage, Achievement do |achievement|
     # achievement.group.has_admin?( user )
    #end
  end
end

