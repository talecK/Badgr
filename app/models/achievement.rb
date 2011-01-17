class Achievement < ActiveRecord::Base
  belongs_to :user
  belongs_to :gemslot
  belongs_to :group
  belongs_to :creator, :class_name => "User"
  attr_accessible :name, :description, :requirements, :image

  has_attached_file :image, :styles => { :thumb  => "50x50#" },
                    :default_url => ('no-gem-image.png' )

  validates( :name, :presence => true )
  validates( :description, :presence => true, :length => { :within => 1...200 } )
  validates( :requirements, :presence => true )

  # paperclip upload validations
  validates_attachment_size :image,
                            :less_than => 5.megabytes,
                            :message => "File must be smaller than 5MB"
  validates_attachment_content_type :image,
                                    :content_type => ['image/jpeg', 'image/jpg', 'image/png','image/gif'],
                                    :message => "Can only upload jpeg, jpg, png and gif file types"
end

