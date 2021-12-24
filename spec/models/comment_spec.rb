require 'rails_helper'

RSpec.describe Comment, type: :model do
    current_user = User.first_or_create!(email: "venky@gmail.com", password: "password", password_confirmation: "password")
    tweet = Tweet.new(
        tweet: '12345',
        user: current_user
    )    
    it "comment to be valid" do
      comment = Comment.new(
          comment: "hi first comment",
          tweet: tweet,
          user: current_user
      )
      expect(comment).to be_valid
    end

end