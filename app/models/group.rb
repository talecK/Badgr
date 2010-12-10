class Group < ActiveRecord::Base

# Setup accessible (or protected) attributes for your model
  attr_accessible :name
		
	validates( :name,  :presence => true) 
end
