class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :banned_by, :class_name => "User"

  validates_inclusion_of :group_admin, :in => [true, false]

  scope :admins, where( :group_admin => true )

  def is_group_admin?
    return self.group_admin
  end

  def make_group_admin!
    self.group_admin = true
    self.save
  end

  def revoke_group_admin!
    self.group_admin = false
    self.save
  end
end

