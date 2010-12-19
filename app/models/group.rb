class Group < ActiveRecord::Base
  has_many :users, :through => :group_users
  has_many :group_users, :dependent => :destroy

# Setup accessible (or protected) attributes for your model
  attr_accessible :name

	validates( :name,  :presence => true,
             :uniqueness => { :case_sensitive => false },
             :length => { :within => 1...25 } )

  def add_user( user )
    self.group_users.create!( :group_id => self.id, :user_id => user.id ,:group_admin => false )
  end

  def remove_user( user )
    self.group_users.find_by_user_id(user).destroy
  end
end

