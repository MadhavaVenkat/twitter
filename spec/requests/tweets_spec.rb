require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  current_user = User.first_or_create!(email: "venky@gmail.com", password: "password", password_confirmation: "password")

  before do
    sign_in(current_user) 
  end

  let(:valid_attributes) do
    {
      tweet: "first tweet",
    }
  end

  let(:invalid_attributes) do
    {
      tweet: "",
    }
    
  end

  describe "GET /index" do
    it "it has get all the tweets" do
      tweet = Tweet.new(valid_attributes) 
      tweet.user = current_user
      tweet.save
      get tweets_path
      expect(response).to have_http_status(200)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "it show tweet" do
      tweet = Tweet.new(valid_attributes)
      tweet.user = current_user
      tweet.save
      get tweet_path(tweet)
      expect(response).to have_http_status(200)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders edit tweets" do
      tweet = Tweet.new(valid_attributes)
      tweet.user = current_user
      tweet.save
      get edit_tweet_url(tweet)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successfull response" do
       get new_tweet_url
       expect(response).to be_successful
    end
  end

  describe "POST /create" do 
    context "with valid parameters" do
      it "create post" do
        expect do
          post tweets_url, params: { tweet: valid_attributes }
        end.to change(Tweet, :count).by(1)
      end

      it "redirect to the created post" do
        post tweets_url, params: { tweet: valid_attributes }
        expect(response).to redirect_to(tweet_url(Tweet.last))
      end
    end

    context "with invalid attributes" do
      it "does not create a invalid attributes" do
        expect do 
          post tweets_url, params: {tweet: invalid_attributes}
        end.to change(Tweet, :count).by(0) 
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          tweet: "new edited tweet"
        }
      end
      it "has edited valid tweet" do
        tweet = Tweet.new(valid_attributes)
        tweet.user = current_user
        tweet.save
        patch tweet_url(tweet), params: {tweet: new_attributes}
        tweet.reload
        expect(tweet).to be_valid
      end

      it "redirects to updated tweet page" do
         tweet = Tweet.new(valid_attributes)
         tweet.user = current_user
         tweet.save
         patch tweet_url(tweet),params: {tweet: new_attributes}
         tweet.reload
         expect(response).to redirect_to(tweet_url(tweet))
         
      end
    end
  end

  describe "DELETE /destroy" do 
    it "destroy the requested tweet" do
      tweet = Tweet.new(valid_attributes)
      tweet.user = current_user
      tweet.save
      expect do
        delete tweet_url(tweet)
      end.to change(Tweet, :count).by(-1)
    end


    it "redirects to tweets list" do
      tweet = Tweet.new(valid_attributes)
      tweet.user = current_user
      tweet.save
      delete tweet_url(tweet)
      expect(response).to redirect_to(tweets_url)
    end
  end
end
