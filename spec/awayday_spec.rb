require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'The Awayday Submission App' do

  before(:each) do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end

  it "shows the form" do
    get '/'
    last_response.should be_ok
    last_response.body.should include('Away Day Brazil')
  end

  it "saves the talk information" do
    post '/talk', params = {:name => "John Presentation",
                            :email => "john.presentation@awayday.com",
                            :title => "The Presentation",
                            :summary => "This is the content",
                            :category => "SIP",
                            :duration => 45 }

    last_response.should be_redirect
    last_response.body.should include('Congratulations John Presentation. Your proposal was sent.')

    Talk.all.should have(1).items

    talk = Talk.first
    talk.title.should == "The Presentation"
    talk.summary.should == "This is the content"
    talk.category.should == "SIP"
    talk.duration.should == 45
    talk.presenter.name.should == "John Presentation"
    talk.presenter.email.should == "john.presentation@awayday.com"
  end

  it "lists the talks" do
    talker = Presenter.new :name => "John Presentation", :email => "john.presentation@awayday.com"
    talk = Talk.new :title => "The Talk", :summary => "Talking Things", :category => "Non-Technical", :duration => 45
    talker.talks << talk
    talk.save!
    talker.save!

    workshoper = Presenter.new :name => "Anna Workshop", :email => "anna.workshop@awayday.com"
    workshop = Talk.new :title => "The Workshop", :summary => "Workshop Stuff", :category => "Hobbies", :duration => "90"
    workshoper.talks << workshop
    workshop.save!
    workshoper.save!

    get '/talks'

    last_response.should be_ok

    should_have_talk talk
    should_have_talk workshop
  end

  def should_have_talk(talk)
    last_response.body.should include("#{talk.presenter.name}")
    last_response.body.should include("#{talk.presenter.email}")
    last_response.body.should include("#{talk.title}")
    last_response.body.should include("#{talk.summary}")
    last_response.body.should include("#{talk.category}")
    last_response.body.should include("#{talk.duration} mins")
  end
end
