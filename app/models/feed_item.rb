class FeedItem < ActiveRecord::Base
  has_many :feeds , :through => :feed_subscriptions
  has_many :feed_subscriptions
  belongs_to :user
  belongs_to :referenced_model, :polymorphic => true

  attr_accessible :feed_type

  validates(:feed_type, :presence => true,
            :inclusion => { :in => [:user_built_hub, :user_joined_hub, :user_left_hub] } )


  def text
    if( self.feed_type.to_sym == :user_built_hub )
      return "#{user.name} built the #{referenced_model.name} Hub"

    elsif ( self.feed_type.to_sym == :user_joined_hub )
      return "#{user.name} is now a member of the #{referenced_model.name} Hub"

    elsif ( self.feed_type.to_sym == :user_left_hub )
      return "#{user.name} has left the #{referenced_model.name} Hub"
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

