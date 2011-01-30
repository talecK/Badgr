Then /^I mouse over "([^"]*)" (?:within "([^"]*)")?$/ do |item, selector|
     puts "$('" + "#{item}" + "').addClass('hover')"
     page.execute_script( "$('" + "#{item}" + "').addClass('hover')" )
end

# added this as a hackish way to confirm js popups
When /^I follow "([^"]*)" and click OK$/ do |text|
  page.evaluate_script("window.alert = function(msg) { return true; }")
  page.evaluate_script("window.confirm = function(msg) { return true; }")
  When %{I follow "#{text}"}
end

# added this as a hackish way to confirm js popups
When /^I press "([^"]*)" and click OK (?:within "([^"]*)")?$/ do |text, selector|
  page.evaluate_script("window.alert = function(msg) { return true; }")
  page.evaluate_script("window.confirm = function(msg) { return true; }")
  with_scope(selector) do
    click_button(text)
  end
end

