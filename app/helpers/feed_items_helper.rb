module FeedItemsHelper

  # return content for a feed item depending on its type, including possibly a link
  # The variables within the string are html escaped using h()

  def feed_item_to_text( feed_item, values = {} )
    #if they pass first_person, give them first person text
    user_name = values[:first_person] == true ? "You" : "#{h(feed_item.user.name)}".html_safe

    if( feed_item.feed_type.to_sym == :user_built_hub )
      group = feed_item.referenced_model
      retVal = "#{h(user_name)} built the #{h(group.name)} Hub"

    elsif ( feed_item.feed_type.to_sym == :user_joined_hub )
      user_qualifier = values[:first_person] == true ? "became" : "is now"
      group = feed_item.referenced_model
      retVal = "#{h(user_name)} #{user_qualifier} a member of the #{h(group.name)} Hub"

    elsif ( feed_item.feed_type.to_sym == :user_left_hub )
      group = feed_item.referenced_model
      retVal = "#{h(user_name)} left the #{h(group.name)} Hub"

    elsif ( feed_item.feed_type.to_sym == :user_forged_achievement )
      achievement = feed_item.referenced_model
      retVal =  "#{h(user_name)} forged the " + link_to( h(achievement.name), group_achievement_path(achievement.group, achievement), :class => "achievementToolTipLink" ) + " Achievement"

    elsif ( feed_item.feed_type.to_sym == :user_banned_from_hub )
      group = feed_item.referenced_model
      retVal =  "#{h(user_name)} was banned from the " + link_to( h(group.name), group_path(group) ) + " Hub"
	
	elsif ( feed_item.feed_type.to_sym == :user_added_friend )
		friend = feed_item.referenced_model
		retVal = "#{h(user_name)} and #{friend.name} are now friends"
	end

    return retVal.html_safe
  end
end

