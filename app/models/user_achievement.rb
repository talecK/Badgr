class UserAchievement < ActiveRecord::Base
  belongs_to :user
  belongs_to :achievement
  belongs_to :presenter, :class_name => "User"
  STATES = { :Pending => 0, :Awarded => 1 }
  validates_presence_of :status, :within => STATES.values

  def present_by(presenting_user)
    self.presenter = presenting_user
    self.status = STATES[:Awarded]
    self.save
  end

  def ordinal_to_state
    UserAchievement::STATES.keys.to_a[status]
  end
end

