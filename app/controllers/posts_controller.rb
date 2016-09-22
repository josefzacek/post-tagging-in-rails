class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 3).order("created_at DESC")
    else
      @posts = Post.paginate(page: params[:page], per_page: 3)
                   .order('created_at DESC')
    end
  end

  def show
    @post = Post.find(params[:id])
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
