class User < ActiveRecord::Base
  has_many :groups, :through => :group_users
  has_many :group_users
  has_many :achievements

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # paperclip attribute ( for file associations / uploads )
  has_attached_file :avatar, :styles => { :thumb  => "50x50#", :medium => "300x300>"},
                    :default_url => ('no-image.png' )

  has_attached_file :gem, :styles => { :thumb  => "50x50#" },
                  :default_url => ('no-gem-image.png' )


  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :name, :gem
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates( :email,  :presence => true,
											:format => { :with => email_regex },
											:uniqueness => { :case_sensitive => false })

  validates( :name, :presence => true )


  # paperclip upload validations
  validates_attachment_size :avatar, :less_than => 5.megabytes, :message => "File must be smaller than 5MB"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'],
                                    :message => "Can only upload jpeg, jpg, png and gif file types"

end

