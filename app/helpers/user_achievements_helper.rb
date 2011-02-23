module UserAchievementsHelper
  def email_to_safe_id(email)
    id = email.gsub('.', '-')
    id = id.gsub('@', '-')
  end
end

