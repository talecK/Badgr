Then /^I should see "([^"]*)" in the gemslot$/ do |gem|
  page.should have_xpath('//a[@title="'+gem+'"]')
end

