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
                            :summary => "The content should be big enough to let people evaluate it",
                            :category => "SIP",
                            :duration => 45 }

    last_response.should be_redirect
    last_response.body.should include('Congratulations John Presentation. Your proposal was sent.')

    Talk.all.should have(1).items
    Presenter.all.should have(1).items

    talk = Talk.first
    talk.title.should == "The Presentation"
    talk.summary.should == "The content should be big enough to let people evaluate it"
    talk.category.should == "SIP"
    talk.duration.should == 45
    talk.presenter.name.should == "John Presentation"
    talk.presenter.email.should == "john.presentation@awayday.com"
  end

  it "shows a error message if some of the params is wrong" do
    post '/talk', params = {:name => "John Presentation",
                            :email => "john.presentation@awayday.com",
                            :title => "The Presentation",
                            :summary => "A small on purpose to make it invalid",
                            :category => "SIP",
                            :duration => 45 }

    last_response.should be_redirect
    last_response.body.should include('Ooops. Something went wrong. Take a look at the following list and fill the form again:')

    Talk.all.should have(0).items
    Presenter.all.should have(0).items
  end

  it "lists the talks" do
    talker = Presenter.new :name => "John Presentation",
                           :email => "john.presentation@awayday.com"
    talk = Talk.new :title => "The Talk",
                    :summary => "Talking Things Talking Things Talking Things Talking",
                    :category => "Non-Technical",
                    :duration => 45
    talker.talks << talk
    talker.save!

    workshoper = Presenter.new :name => "Anna Workshop", :email => "anna.workshop@awayday.com"
    workshop = Talk.new :title => "The Workshop",
                        :summary => "Workshop Stuff Workshop Stuff Workshop Stuff Workshop",
                        :category => "Hobbies",
                        :duration => "90"
    workshoper.talks << workshop
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
