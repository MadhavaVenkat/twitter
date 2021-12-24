require 'rails_helper'

RSpec.describe 'tweets/index' , type: :view do
    current_user = User.first_or_create!(email: "venky@gmail.com", password: "password", password_confirmation: "password")
    before(:each) do 
      assign(:tweets, [ Tweet.create!(
          tweet: "hi first tweet",
          user: current_user
      ),
      Tweet.create!(
        tweet: "hi first tweet",
        user: current_user
    )  
        ])
    end
    
    it "renders list of tweets" do 
      render

      assert_select 'div>div>div', text: "Tweet by #{"#{"#{current_user.email}".match(/^\s*[A-Z]+/i)}".upcase.to_s} !" , count: 2
      assert_select 'div>h5', text: 'hi first tweet'.to_s, count: 2
      assert_select 'div>p', text: 'Comments: 0'.to_s , count: 2

    end

end