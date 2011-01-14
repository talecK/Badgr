class Group < ActiveRecord::Base
  has_many :users, :through => :memberships
  has_many :memberships, :dependent => :destroy
  has_one :feed, :as => :source
  has_many :feed_items, :as => :referenced_model


  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :avatar

  after_create :create_feed_for_group

	validates( :name,  :presence => true,
             :uniqueness => { :case_sensitive => false },
             :length => { :within => 1...25 } )

  # paperclip attribute ( for file associations / uploads )
  has_attached_file :avatar, :styles => { :thumb  => "50x50#", :medium => "300x300>"},
                    :default_url => 'no-image-:style.png'

  # paperclip upload validations
  validates_attachment_size :avatar, :less_than => 5.megabytes, :message => "File must be smaller than 5MB"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
                                    :message => "Can only upload jpeg, jpg, png and gif file types"


  def add_creator( user )
    self.memberships.create( :group_id => self.id, :user_id => user.id ,:group_admin => true )
    self.feed.add_creation_feed_item( user, self )
  end

  def add_user( user )
    self.memberships.create( :group_id => self.id, :user_id => user.id ,:group_admin => false )
    self.feed.add_user_joined_feed_item( user, self )
  end

  def remove_user( user )
    self.memberships.find_by_user_id(user).destroy
    self.feed.add_user_left_feed_item( user, self )
  end

  def has_member?( user )
    self.users.exists?(user)
  end


  def create_feed_for_group
    self.create_feed
  end
end

