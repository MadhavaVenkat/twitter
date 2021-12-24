require 'rails_helper'

RSpec.describe Tweet, type: :model do
  
  current_user = User.first_or_create!(email: "venky@gmail.com", password: "password", password_confirmation: "password")

  context "it is tests for :tweet field" do
    it "has a tweet" do 

      tweet = Tweet.new(
        tweet: '',
        user: current_user
      )
      expect(tweet).to_not be_valid
      tweet.tweet = "Hi Venky"
      expect(tweet).to be_valid
    end

    it "has a tweet between 5 and 100 characters" do
      tweet = Tweet.new(
        tweet: '12345',
        user: current_user
      )
    expect(tweet).to be_valid
    hundred_char_string = "1A8AxFpliXh7zFWg6icOqP9bjNe1m6Vj82YUzGQqrhzHvb65NlOXzrIrRRuC1tvOr4zupRFHOB0suJAJk5n5bCdcxGUM8S6PM9o0"
    tweet.tweet = hundred_char_string
    expect(tweet).to be_valid

    tweet.tweet = hundred_char_string + "1"
    expect(tweet).to_not be_valid

    end

  end
end
