Given /^my name is Neil Craven$/ do
  visit('/')
  @presenter = Presenter.new :name => "Neil Craven"
  fill_in 'Name', :with => @presenter.name
end

Given /^my talk proposal has the following information$/ do |table|
  hashes = table.hashes.first
  @talk = Talk.new :title => hashes['Talk Title'], :subject => hashes['Subject'], :category => hashes['Category'], :duration => hashes['Duration']
  @presenter.talks << @talk

  fill_in 'Talk Title', :with => @talk.title
  fill_in 'Subject', :with => @talk.subject
  fill_in 'Category', :with => @talk.category
  fill_in 'Duration', :with => @talk.duration
end

When /^I submit my talk proposal$/ do
  click_button "Submit"
end

Then /^I will be in the list of possible presenters$/ do
  Presenter.all.size.should be 1
end

Then /^my talk proposal will be on the list of talk proposals$/ do
  Talk.all.size.should be 1
end

Then /^I will see a confirmation that my proposal has been submitted$/ do
  page.should have_content "Congratulations"
end

Then /^I will be told that I need to check my information for problems$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will be able to resubmit$/ do
  pending # express the regexp above with the code you wish you had
end
