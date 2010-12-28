class Group < ActiveRecord::Base
  has_many :users, :through => :memberships
  has_many :memberships, :dependent => :destroy

# Setup accessible (or protected) attributes for your model
  attr_accessible :name

	validates( :name,  :presence => true,
             :uniqueness => { :case_sensitive => false },
             :length => { :within => 1...25 } )

  def add_user( user )
    self.memberships.create!( :group_id => self.id, :user_id => user.id ,:group_admin => false )
  end

  def remove_user( user )
    self.memberships.find_by_user_id(user).destroy
  end
end

