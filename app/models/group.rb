class Group < ActiveRecord::Base
  has_many :users, :through => :memberships
  has_many :memberships, :dependent => :destroy
  has_one :feed, :as => :source
  has_many :feed_item_model_refs, :as => :referenced_model, :class_name => "FeedItem"
  has_many :achievements


  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :avatar

  after_create :create_feed_for_group

	validates( :name,  :presence => true,
             :uniqueness => { :case_sensitive => false },
             :length => { :within => 1...25 } )

  # paperclip attribute ( for file associations / uploads )
  has_attached_file :avatar, :styles => { :thumb  => "50x50#", :original => "300x300>"},
                    :default_url => 'no-image-:style.png',
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
                    :path => "Groups/:id/Avatar/:style.:extension"

  # paperclip upload validations
  validates_attachment_size :avatar, :less_than => 5.megabytes, :message => "File must be smaller than 5MB"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
                                    :message => "Can only upload jpeg, jpg, png and gif file types"


  def add_creator( user )
    self.memberships.create( :group_id => self.id, :user_id => user.id ,:group_admin => true, :group_creator => true )
  end

  def add_user( user )
    self.memberships.create( :group_id => self.id, :user_id => user.id ,:group_admin => false )
  end

  def remove_user( user )
    self.memberships.find_by_user_id(user).destroy
  end

  def has_member?( user )
    self.users.exists?(user)
  end

  def create_feed_for_group
    self.create_feed
  end

  def has_admin?( user )
    self.memberships.admins.exists?( :user_id => user.id )
  end

  def make_admin!( user )
    membership = self.memberships.where( :user_id => user.id ).limit(1).first
    membership.make_group_admin! unless membership.nil?
  end
end

