class Group < ActiveRecord::Base
  has_many :users, :through => :group_users
  has_many :group_users, :dependent => :destroy

# Setup accessible (or protected) attributes for your model
  attr_accessible :name

	validates( :name,  :presence => true)

end

