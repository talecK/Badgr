class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  attr_accessible :group_admin, :group_id, :user_id, :group_creator
  validates_inclusion_of :group_admin, :in => [true, false]

  scope :admins, where( :group_admin => true )

  def is_group_admin?
    return self.group_admin
  end

  def make_group_admin!
    self.group_admin = true
  end

  def revoke_group_admin!
    self.group_admin = false
  end
end

