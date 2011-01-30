module MembershipsHelper

  #remove dashes and @ symbols for id to work
  def email_to_safe_id(email)
    id = email.gsub('.', '-')
    id = id.gsub('@', '-')
  end

  def ban_button_for(group, user)
    button_to( "Ban", group_membership_path(@group, user.memberships.find_by_group_id(@group) ), :method => "delete",
                         :confirm => "Are you sure you want to ban this member? This action cannot be undone!"
                 )
  end
end

