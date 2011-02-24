module AchievementsHelper
  def status_or_request_link(achievement)
    if( current_user.has_pending_achievement?(achievement) )
      "| Pending |".html_safe
    elsif( current_user.has_earned_achievement?(achievement) )
      "| Awarded |".html_safe
    else
      link_to( "| Request |", new_user_user_achievement_path( current_user, :achievement_id => achievement.id ) )
    end
  end
end

