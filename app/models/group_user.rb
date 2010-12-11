class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  attr_accessible :group_admin, :group_id, :user_id
  validates( :group_admin, :presence => true)
end

