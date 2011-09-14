Given /^my name is (.*) and my email is (.*)$/ do |name, email|
  visit('/')
  @presenter = Presenter.new :name => name, :email => email
  fill_in 'Name', :with => @presenter.name
  fill_in 'Email', :with => @presenter.email
end

Given /^my (.*) proposal has the following information$/ do |type, table|
  hashes = table.hashes.first
  @talk = Talk.new :title => hashes['Title'], :summary => hashes['Summary'], :category => hashes['Category'], :duration => hashes['Duration']
  @presenter.talks << @talk

  fill_in 'Title', :with => @talk.title
  fill_in 'Summary', :with => @talk.summary
  select @talk.category, :from=>"category"
  choose @talk.duration
end

When /^I submit my (.*) proposal$/ do |proposal|
  click_button "Submit"
end

Then /^I will be in the list of possible presenters$/ do
  Presenter.all.size.should be 1
end

Then /^I wont be in the list of possible presenters$/ do
  Presenter.all.size.should be 0
end

Then /^my (.*) proposal will be on the list of proposals$/ do |proposal|
  Talk.all.size.should be 1
end

Then /^my (.*) proposal wont be on the list of proposals$/ do |proposal|
  Talk.all.size.should be 0
end

Then /^I will see a confirmation that my proposal has been submitted$/ do
  page.should have_content "Congratulations #{@presenter.name}. Your proposal was sent."
end

Then /^I will see a message stating that something went wrong$/ do
  page.should have_content "Ooops. Something went wrong. Take a look at the following list and fill the form again:"
end

Then /^a message saying that the summary is too short$/ do
  page.should have_content "Summary:"
  page.should have_content "Is too short (minimum is 50 characters)."
end

Then /^I will be told that I need to check my information for problems$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will be able to resubmit$/ do
  pending # express the regexp above with the code you wish you had
end
