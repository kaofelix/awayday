require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'models', 'talk')

describe 'A Talk' do

  before(:each) do
    @talk = Talk.new :title => "The Title",
                     :summary => "The content",
                     :category => "SIP",
                     :duration => 45
    @presenter = Presenter.new :name => "John Presentation", :email => "john.presentation@awayday.com", :talks => [@talk]
  end

  it "should have a title, a summary, a category, a duration and a presenter" do
    @talk.should be_valid
  end

  it "should not be valid if the title is missing" do
    @talk.title = nil
    @talk.should_not be_valid
  end

  it "should not be valid if there is no summary" do
    @talk.summary = nil
    @talk.should_not be_valid
  end

  it "should not be valid if no category was selected" do
    @talk.category = nil
    @talk.should_not be_valid
  end

  it "should not be valid if there is no duration" do
    @talk.duration = nil
    @talk.should_not be_valid
  end

  it "should not be valid if there is nobody to present" do
    @talk.presenter = nil
    @talk.should_not be_valid
  end

end
