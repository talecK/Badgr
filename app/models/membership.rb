class Membership < ActiveRecord::Base
  ROLES = %w[member group_admin group_creator]
  belongs_to :group
  belongs_to :user
  belongs_to :banned_by, :class_name => "User"

  validates_inclusion_of :role, :in => ROLES

  scope :admins, where( :role => "group_admin" )
  scope :creator, where(:role => "group_creator")

  def is_group_admin?
    return role == ROLES[1]
  end

  def is_group_creator?
    return role == ROLES[2]
  end

  def make_group_admin!
    self.role = ROLES[1]
    self.save
  end

  def revoke_group_admin!
    self.role = ROLES[0]
    self.save
  end

  def rank
    if self.role == ROLES[2]
      return 2
    elsif self.role == ROLES[1]
      return 1
    elsif self.role == ROLES[0]
      return 0
    end
  end
end

