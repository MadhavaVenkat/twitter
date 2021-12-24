class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create]

  # GET /comments or /comments.json
  def index
    #byebug
    #@tweet = Tweet.find(params.require(:tweet).permit(:tweet_id))
    #@comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    
    @tweet = Tweet.find(params[:tweet_id])
    
    @comment = @tweet.comments.new(comment_params)
    @comment.user = current_user
    #@comment.tweet = Tweet.find(id: :tweet_id)
    
    #byebug
    respond_to do |format|
      if @comment.save
        session[:tweet_id] = @comment.tweet.id
        format.html { redirect_to tweet_path(@tweet) , notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        #render :new
        #flash[:notice] = "comm is invalid"
        redirect_to tweet_path(@tweet)
        #format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:comment, :tweet_id, :user_id)
    end
end
