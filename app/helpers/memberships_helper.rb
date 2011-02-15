module MembershipsHelper

  #remove dashes and @ symbols for id to work
  def email_to_safe_id(email)
    id = email.gsub('.', '-')
    id = id.gsub('@', '-')
  end

  def ban_button_for(group, user)
    button_to( "Ban", ban_group_membership_path(group, group.get_membership(user) ), :method => "delete",
                         :confirm => "Are you sure you want to ban this member? This action cannot be undone!"
             )
  end

  def promote_button_for(group, user)
    membership = group.get_membership( user )
    form_for [ group, membership ] do |f|
      f.submit( "Promote", :onclick => "return confirm(\"Are you sure you want to promote #{user.email} to an officer?\")" )
    end
  end

  def demote_button_for(group, user)
    membership = group.get_membership( user )
    form_for [ group, membership ] do |f|
      f.submit( "Demote", :onclick => "return confirm(\"Are you sure you want to demote #{user.email} to a regular member?\")" )
    end
  end
end

