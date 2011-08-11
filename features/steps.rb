Given /^my name is Neil Craven$/ do
  visit('/')
  fill_in 'Name', :with => 'Neil Craven'
end

Given /^my talk proposal has the following information$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

When /^I submit my talk proposal$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^my talk proposal will be on the list of talk proposals$/ do
  pending # express the regexp above with the code you wish you had
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
