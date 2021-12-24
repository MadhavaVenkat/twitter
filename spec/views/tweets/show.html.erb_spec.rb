require 'rails_helper'

RSpec.describe 'posts/show', type: :view do 
  current_user = User.first_or_create!(email: "venky@gmail.com", password: "password", password_confirmation: "password")
  before(:each) do 
    @tweet = assign(:tweet, Tweet.create!(
        tweet: "hi this is first tweet",
        user: current_user
    )) 
  end

  it "renders attributes in <p>" do
    render @tweet
    expect(rendered).to match(/hi this is first tweet/)
    expect(rendered).to match(/1/)
  end

end
