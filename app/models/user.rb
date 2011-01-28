class User < ActiveRecord::Base
  has_many :groups, :through => :memberships
  has_many :memberships
  has_many :achievements
  belongs_to :gem, :class_name => "Achievement"
  has_one :feed, :as => :source
  has_many :feed_item_model_refs, :as => :referenced_model, :class_name => "FeedItem"
  has_many :feed_item_user_refs, :class_name => "FeedItem"
  has_many :achievement_creator_refs, :class_name => "Achievement"
  ROLES = %w[super_admin]


  after_create :create_feed_for_user#, :create_gem

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # paperclip attribute ( for file associations / uploads )
  has_attached_file :avatar, :styles => { :thumb  => "50x50#", :original => "300x300>"},
                    :default_url => 'no-image-:style.png',
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
                    :path => "Users/:id/Avatar/:style.:extension"

  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :name
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates( :email,  :presence => true,
											:format => { :with => email_regex },
											:uniqueness => { :case_sensitive => false })

  validates( :name, :presence => true )


  # paperclip upload validations
  validates_attachment_size :avatar, :less_than => 5.megabytes, :message => "File must be smaller than 5MB"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
                                    :message => "Can only upload jpeg, jpg, png and gif file types"

  def make_super_admin!
    self.role = User::ROLES[0]
    self.save
  end

  def revoke_super_admin!
    self.role = nil
    self.save
  end

  def create_feed_for_user
    self.create_feed
  end

 # def create_gem
  #  self.create_gemslot
  #end
end

