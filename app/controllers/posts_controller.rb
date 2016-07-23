class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.js
      else
        format.html { render root_path }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:author, :content, :all_tags)
  end
end
