module GroupsHelper

  def link_for_leave_group(group, user)
     link_to "Leave group", group_membership_path( group, user ), :method => :delete,
                                  :confirm => "Are you sure you want to leave this group?"
  end
end

