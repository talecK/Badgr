class FeedItem < ActiveRecord::Base
  has_many :feeds , :through => :feed_subscriptions
  has_many :feed_subscriptions
  belongs_to :user
  belongs_to :referenced_model, :polymorphic => true

  attr_accessible :feed_type

  validates(:feed_type, :presence => true,
            :inclusion => { :in => [:user_built_hub, :user_joined_hub,
                                    :user_left_hub, :user_forged_achievement]
                          }
           )


  def text( values = {} )
    #if they pass first_person, give them first person text
    user_name = values[:first_person] == true ? "You" : "#{user.name}"

    if( self.feed_type.to_sym == :user_built_hub )
      return "#{user_name} built the #{referenced_model.name} Hub"

    elsif ( self.feed_type.to_sym == :user_joined_hub )
      user_qualifier = values[:first_person] == true ? "became" : "is now"
      return "#{user_name} #{user_qualifier} a member of the #{referenced_model.name} Hub"

    elsif ( self.feed_type.to_sym == :user_left_hub )
      return "#{user_name} left the #{referenced_model.name} Hub"
    elsif ( self.feed_type.to_sym == :user_forged_achievement )
      return "#{user_name} forged the '#{referenced_model.name}' Achievement"
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

