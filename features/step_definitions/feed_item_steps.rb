Then /^I should see the time the feed item was created for "([^"]*)" joining the "([^"]*)" Hub$/ do |user_email, group_name|
  @group = Group.find_by_name(group_name)
  @user = User.find_by_email(user_email)
  feed_item = @group.feed.feed_items.where( :feed_type => :user_joined_hub, :referenced_model_id => @group.id, :user_id => @user.id ).first
  creation_time = feed_item.creation_time
  creation_date = feed_item.creation_date

  #search within the scope of the feed_item div itself for the time
  with_scope( "#hub_feed #feed_item#{feed_item.id}" ) do
    if page.respond_to? :should
      page.should have_content(creation_time)
      page.should have_content(creation_date)
    else
      assert page.has_content?(creation_time)
      assert page.has_content?(creation_date)
    end
  end
end

When /^I click remove for the feed item with reference "([^"]*)", source "([^"]*)" and type "([^"]*)"$/ do |reference, source, type|
  if (type.to_sym == :user_joined_hub)
    @group = Group.find_by_name(source)
    @user = User.find_by_email(reference)
    feed_item = @group.feed.feed_items.where( :feed_type => :user_joined_hub, :referenced_model_id => @group.id, :user_id => @user.id ).first
  end

  with_scope("#hub_feed #feed_item#{feed_item.id}") do
    click_link("x")
  end
end

Then /^I should see "([^"]*)" "([^"]*)" time(?:|s) (?:within "([^"]*)")?$/ do |text, occourences, selector|
  page.should have_xpath( selector.to_s, :text => text, :count => occourences.to_i )
end

