class UserAchievement < ActiveRecord::Base
  belongs_to :user
  belongs_to :achievement
  belongs_to :presenter, :class_name => "User"
  STATES = { :pending => 0, :awarded => 1 }
  validates_presence_of :status, :within => STATES.values

  def present_by(presenting_user)
    self.presenter = presenting_user
    self.status = STATES[:awarded]
    self.save
  end
end

