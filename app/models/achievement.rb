class Achievement < ActiveRecord::Base
  has_many :users, :through => :user_achievements
  has_many :gemslot_refs, :class_name => "User"
  belongs_to :group
  belongs_to :creator, :class_name => "User"
  attr_accessible :name, :description, :requirements, :image

  has_attached_file :image, :styles => { :thumb  => "50x50#", :original => "300x300>" },
                    :default_url => ('no-gem-image.png' ),
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml",
                    :path => "Achievements/:id/:style.:extension"

  validates( :name, :presence => true )
  validates( :description, :presence => true, :length => { :within => 1...200 } )
  validates( :requirements, :presence => true )
  validates_uniqueness_of :name, :scope => :group_id, :case_sensitive => false

  # paperclip upload validations
  validates_attachment_size :image,
                            :less_than => 5.megabytes,
                            :message => "File must be smaller than 5MB"
  validates_attachment_content_type :image,
                                    :content_type => ['image/jpeg', 'image/jpg', 'image/png','image/gif'],
                                    :message => "Can only upload jpeg, jpg, png and gif file types"

  def as_json( options = {} )
    {
      :image => "#{image_url}", :name => "#{self.name}",
      :description => "#{self.description}", :requirements => "#{requirements}"
    }
  end

  def image_url
    image.url( :thumb )
  end
end

