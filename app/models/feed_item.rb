class FeedItem < ActiveRecord::Base
  has_many :feeds , :through => :feed_subscriptions
  has_many :feed_subscriptions
  belongs_to :user
  belongs_to :referenced_model, :polymorphic => true

  VISIBILITY = { :public => 0, :private => 1 }

  validates(:feed_type, :presence => true,
            :inclusion => { :in => [:user_built_hub, :user_joined_hub, :user_earned_achievement,
                                    :user_requested_achievement, :user_denied_achievement,
                                    :user_left_hub, :user_forged_achievement, :user_banned_from_hub,
									                  :user_added_friend]
                          }
           )

  validates( :visibility, :presence => true, :inclusion => { :in => VISIBILITY.values } )

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

  def make_private!
    self.visibility = VISIBILITY[:private]
    self.save
  end

end

