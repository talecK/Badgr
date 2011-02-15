class UserAchievement < ActiveRecord::Base
  belongs_to :user
  belongs_to :achievement
  belongs_to :presenter, :class_name => "User"

  validates_presence_of :status, :within => [:pending, :awarded]

  def present_by(presenting_user)
    self.presenter = presenting_user
    self.status = :awarded
    self.save
  end
end

