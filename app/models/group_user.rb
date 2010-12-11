class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  attr_accessible :group_admin
end

