class Gemslot < ActiveRecord::Base
  belongs_to :user
  has_one :achievement
end

