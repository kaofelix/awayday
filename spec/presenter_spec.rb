require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'models', 'presenter')

describe 'A Presenter' do

  before(:each) do
    @talk = Talk.new :title => "The Title",
                     :summary => "The content should be big enough to let people evaluate it",
                     :category => "SIP",
                     :duration => 45

    @presenter = Presenter.new :name => "John Presentation", :email => "john.presentation@awayday.com", :talks => [@talk]
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end

  it "should have a name, a email and at least one talk" do
    @presenter.should be_valid
  end

  it "should have a unique name" do
    other_presenter = Presenter.new :name => "John Presentation", :email => "wathever@blah.com", :talks => [Talk.new]

    @presenter.should be_valid
    @presenter.save
    other_presenter.should_not be_valid
  end

  it "should have a unique email" do
    other_presenter = Presenter.new :name => "Not John Presentation", :email => "john.presentation@awayday.com", :talks => [Talk.new]

    @presenter.should be_valid
    @presenter.save
    other_presenter.should_not be_valid
  end

  it "should have a email with valid format" do
    @presenter.email.should match /\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/
  end

  it "should not be valid if the name is missing" do
    @presenter.name = nil
    @presenter.should_not be_valid
  end

  it "should not be valid if the email is missing" do
    @presenter.email = nil
    @presenter.should_not be_valid
  end

  it "should not be valid if the email has a invalid format" do
    @presenter.email = "blhjash@jjjaslkpapa.alkjasdl"
    @presenter.should_not be_valid
  end

  it "should not be valid if has nothing to present" do
    @presenter.talks = nil
    @presenter.should_not be_valid
  end

end
