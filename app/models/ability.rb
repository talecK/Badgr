class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # guest user (not logged in)

    can [:read, :create], Group
    can :read, User

    # can ban the other membership if the current user's membership for the
    # group that the other membership belongs to outranks the other membership
    # this clause also catches the case of user trying to ban themselves,
    # they won't be able to since the rank is the same
    can :destroy, Membership do |membership|
      membership.group.get_membership(user) != nil &&
      membership.group.get_membership(user).rank > membership.rank
    end

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
  end
end

