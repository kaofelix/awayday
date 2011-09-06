Given /^my name is (.*)$/ do |name|
  visit('/')
  @presenter = Presenter.new :name => name
  fill_in 'Name', :with => @presenter.name
end

Given /^my (.*) proposal has the following information$/ do |type, table|
  hashes = table.hashes.first
  @talk = Talk.new :title => hashes['Talk Title'], :subject => hashes['Subject'], :category => hashes['Category'], :duration => hashes['Duration']
  @presenter.talks << @talk

  fill_in 'Talk Title', :with => @talk.title
  fill_in 'Subject', :with => @talk.subject
  fill_in 'Category', :with => @talk.category
  choose @talk.duration
end

When /^I submit my (.*) proposal$/ do |proposal|
  click_button "Submit"
end

Then /^I will be in the list of possible presenters$/ do
  Presenter.all.size.should be 1
end

Then /^my (.*) proposal will be on the list of proposals$/ do |proposal|
  Talk.all.size.should be 1
end

Then /^I will see a confirmation that my proposal has been submitted$/ do
  page.should have_content "Congratulations, #{@presenter.name}."
  page.should have_content "Your proposal '#{@talk.title}' was submitted."
  page.should have_content "You will have #{@talk.duration} to present in the category #{@talk.category}."
end

Then /^I will be told that I need to check my information for problems$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will be able to resubmit$/ do
  pending # express the regexp above with the code you wish you had
end
