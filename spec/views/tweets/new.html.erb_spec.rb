require 'rails_helper'

RSpec.describe 'tweets/new', type: :view do
    current_user = User.first_or_create!(email: "venky@gmail.com", password: "password", password_confirmation: "password")
    before(:each) do 
      assign(:tweet, Tweet.new(
          tweet: 'Hi this is first tweet',
          user: current_user
      ))
    end

    it " it renders new post form" do
      render
      assert_select 'form[action=?][method=?]', tweets_path ,"post" do
        assert_select 'textarea[name=?]', "tweet[tweet]"
      end
    end

end