Given /^my name is Neil Craven$/ do
  visit('/')
  fill_in 'Name', :with => 'Neil Craven'
end

Given /^my talk proposal has the following information$/ do |table|
  talk = table.hashes.first
  fill_in 'Talk Title', :with => talk['Talk Title']
  fill_in 'Subject', :with => talk['Subject']
  fill_in 'Category', :with => talk['Category']
  fill_in 'Duration', :with => talk['Duration']
end

When /^I submit my talk proposal$/ do
  find(:css, "input[type='submit']").click
end

Then /^my talk proposal will be on the list of talk proposals$/ do
  pending # TalkProposals.find_all.should_contain @my_talk
end

Then /^I will see a confirmation that my proposal has been submitted$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will be told that I need to check my information for problems$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will be able to resubmit$/ do
  pending # express the regexp above with the code you wish you had
end
