class FeedItem < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  attr_accessible :feed_type, :reference_id

  validates(:feed_type, :presence => true,
            :inclusion => { :in => [:user_built_hub, :user_joined_hub, :user_left_hub] } )

  def reference
    unless( self.reference_id.nil? )
      type = self.feed_type.to_sym

      #if reference is a user
      if( type == :user_built_hub || type == :user_joined_hub || type == :user_left_hub )
        return User.find( self.reference_id )
      end
    end
  end

  def text
    if( self.feed_type.to_sym == :user_built_hub )
      return "#{User.find(reference_id).name} built the #{source.name} Hub"

    elsif ( self.feed_type.to_sym == :user_joined_hub )
      return "#{User.find(reference_id).name} is now a member of the #{source.name} Hub"

    elsif ( self.feed_type.to_sym == :user_left_hub )
      return "#{User.find(reference_id).name} has left the #{source.name} Hub"
    end
  end

  #return a formated creation time (year-month-day /n H:M:S am/pm)
  def creation_date
    return created_at.strftime("%F")
  end

  def creation_time
    time = created_at.strftime("%I:%M %P")

    #if the first character of the time string is a 0, drop it
    if ( time[0] == '0' )
     return time[1..time.length]
    else
      return time
    end
  end
end

