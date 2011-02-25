module GroupsHelper

  def link_for_leave_group(group, user)
     link_to "Leave group", group_membership_path( group, group.get_membership(user) ), :method => :delete,
                                  :confirm => "Are you sure you want to leave this group?"
  end

  def group_name_helper(group)
    membership = group.get_membership(current_user)
    if( membership.is_group_admin? )
      identifier = "(admin)"
    elsif( membership.is_group_creator? )
      identifier = "(creator)"
    end
   link_to("#{group.name} #{identifier}", group_path( group ) )
  end
end

