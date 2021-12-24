require 'rails_helper'

RSpec.describe 'tweets/edit', type: :view do
  current_user = User.first_or_create!(email: "venky@gmail.com", password: "password", password_confirmation: "password")
  before(:each) do 
    @tweet = assign(:tweet, Tweet.create!(
        tweet: "this edit tweet",
        user: current_user
    ))
  end

  it "it renders the edit tweet form" do
    render

    assert_select "form[action=?][method=?]",tweet_path(@tweet), "post" do 
      assert_select "textarea[name=?]","tweet[tweet]"
    end
  end
end