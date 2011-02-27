class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # guest user (not logged in)

    can [:read, :create], Group
    can :read, User

    # can ban the other membership if the current user's membership for the
    # group that the other membership belongs to outranks the other membership
    can :destroy, Membership do |membership|
      membership.group.get_membership(user) != nil &&
      membership.group.get_membership(user).rank > membership.rank
    end

    can :create_achievements, Group do |group|
      group.get_membership(user) != nil &&
      group.get_membership(user).rank >= 1
    end

    can :update, Group do |group|
      group.get_membership(user) != nil &&
      group.get_membership(user).rank >= 1
    end

    can :manage, User do |curr_profile|
      user == curr_profile
    end

    # can promote another member as long as the current_user is a group_creator for the same group
    # as promotee, and the promotee isn't already a group_creator or a group_admin
    can :promote, Membership do |membership|
      membership.group.get_membership(user) != nil &&
      membership.group.get_membership(user).is_group_creator? &&
      membership.role == Membership::ROLES[0]
    end

    can :demote, Membership do |membership|
      membership.group.get_membership(user) != nil &&
      membership.group.get_membership(user).is_group_creator? &&
      membership.role == Membership::ROLES[1]
    end

    can :request_achievement, Achievement do |achievement|
      user.has_pending_achievement?(achievement) == false &&
      user.has_earned_achievement?(achievement) == false
    end

    can [:award, :deny], UserAchievement do |user_achievement|
      user_achievement.user != user &&                                       # can't award yourself achievements
      user_achievement.achievement.group.get_membership(user).rank >= 1 &&   # the user's rank in the group is admin or higher
      user_achievement.status == UserAchievement::STATES[:Pending]
    end

    can :read, FeedItem, :visibility => FeedItem::VISIBILITY[:public]
    can :read, FeedItem, :user_id => user.id, :visibility => FeedItem::VISIBILITY[:private]

    # can manage all if user is super_admin
    can :manage, :all if user.role == User::ROLES[0]

    # make sure a user can't ban themselves (only really necesssary for super_admin)
    cannot :destroy, Membership do |membership|
      user == membership.user
    end

    # make sure a user can't promote themselves (only really necesssary for super_admin)
    # and they can't promote users beyond group_creator
    cannot :promote, Membership do |membership|
      user == membership.user ||
      membership.rank >= 1
    end

    cannot :demote, Membership do |membership|
      user == membership.user ||
      membership.rank < 1
    end
  end
end

