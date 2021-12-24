require 'rails_helper'

RSpec.describe TweetsController , type: :controller do
  current_user = User.first_or_create!(email: "venky@gmail.com", password: "password", password_confirmation: "password")  

  let(:tweet_attributes) do
    {
      tweet: "Hi venky",
      user: current_user
    }
  end

  before do
    sign_in(current_user)
  end

  describe "GET index" do
    it "it has http status 200" do
      get :index
      expect(response.status).to eq(200)
      
    end
  end

  describe " GET new" do
    render_views
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET edit" do
    render_views    
    it "renders edit template" do
      tweet = Tweet.new(tweet_attributes)
      tweet.save
      get :edit, params: {id: tweet.id}
      expect(response).to render_template("edit")
    end
  end
end