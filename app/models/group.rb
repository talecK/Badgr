class Group < ActiveRecord::Base
  has_many :users, :through => :memberships
  has_many :memberships, :dependent => :destroy
  has_many :feed_items, :as => :source, :dependent => :destroy

# Setup accessible (or protected) attributes for your model
  attr_accessible :name

	validates( :name,  :presence => true,
             :uniqueness => { :case_sensitive => false },
             :length => { :within => 1...25 } )

  def add_creator( user )
    self.memberships.create( :group_id => self.id, :user_id => user.id ,:group_admin => true )
    add_creation_feed_item( user )
  end

  def add_user( user )
    self.memberships.create( :group_id => self.id, :user_id => user.id ,:group_admin => false )
    add_user_joined_feed_item( user )
  end

  def remove_user( user )
    self.memberships.find_by_user_id(user).destroy
    add_user_left_feed_item( user )
  end

  def has_member?( user )
    self.users.exists?(user)
  end

  # def find_feed_item( values = {} )
   # self.feed_items.to_ary.find { |item| ( item.source == values[:source] ) }
  # end

  def add_creation_feed_item( creator )
    self.feed_items.create!( :reference_id => creator.id, :feed_type => :user_built_hub )
  end

  def add_user_joined_feed_item( user )
    self.feed_items.create!( :reference_id => user.id, :feed_type => :user_joined_hub)
  end

  def add_user_left_feed_item( user )
    self.feed_items.create!( :reference_id => user.id, :feed_type => :user_left_hub )
  end
end

