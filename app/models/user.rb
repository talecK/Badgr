class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
	attr_accessible :name, :email
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates( :name, 	:presence => true, 
											:length => { :maximum => 30 } )
	validates( :email,  :presence => true,
											:format => { :with => email_regex },
											:uniqueness => { :case_sensitive => false }) 
	
end

