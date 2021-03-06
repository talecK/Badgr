class User < ActiveRecord::Base
  has_many :groups, :through => :memberships
  has_many :memberships
  has_many :achievements, :through => :user_achievements
  has_many :user_achievements
  belongs_to :gem, :class_name => "Achievement"
  has_one :feed, :as => :source
  has_many :feed_item_model_refs, :as => :referenced_model, :class_name => "FeedItem"
  has_many :feed_item_user_refs, :class_name => "FeedItem"
  has_many :achievement_creator_refs, :class_name => "Achievement"
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :banned_by_refs, :class_name => "Membership"
  has_many :presenter_refs, :class_name => "UserAchievement"
  ROLES = %w[super_admin]

  after_create :create_feed_for_user

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
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def has_friend?(friend)
	@friendship = Friendship.find_by_user_id_and_friend_id(self.id, friend.id)
		if @friendship.nil?
			@friendship = Friendship.find_by_user_id_and_friend_id(friend.id, self.id)
			if @friendship.nil?
				return nil
			else
				return @friendship
			end
		else
			return @friendship
		end
	end

  def request_achievement( achievement )
    if( achievement != nil && self.user_achievements.exists?( :achievement_id => achievement.id ) == false )
      @user_achievement = self.user_achievements.create( :status => UserAchievement::STATES[:Pending], :achievement_id =>  achievement.id )
    else
      return false
    end
  end

  def has_pending_achievement?( achievement )
    self.user_achievements.exists?( :achievement_id => achievement.id, :status => UserAchievement::STATES[:Pending] )
  end

  def has_earned_achievement?( achievement )
    self.user_achievements.exists?( :achievement_id => achievement.id, :status => UserAchievement::STATES[:Awarded] )
  end

  def has_denied_achievement?( achievement )
    self.user_achievements.exists?( :achievement_id => achievement.id, :status => UserAchievement::STATES[:Denied] )
  end

 # def create_gem
  #  self.create_gemslot
  #end
end

