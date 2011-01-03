class Gemslot < ActiveRecord::Base
  belongs_to :user
  has_one :achievement

  after_create :build_achievement_relationship

  def build_achievement_relationship
    self.create_achievement
  end
end

