module MembershipsHelper

  #remove dashes and @ symbols for id to work
  def email_to_safe_id(email)
    id = email.gsub('.', '-')
    id = id.gsub('@', '-')
  end

  def ban_button_for(group, user)
    button_to( "Ban", ban_group_membership_path(@group, @group.get_membership(user) ), :method => "delete",
                         :confirm => "Are you sure you want to ban this member? This action cannot be undone!"
             )
  end
end

