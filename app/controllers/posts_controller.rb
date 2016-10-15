class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
                   .paginate(page: params[:page], per_page: 3)
                   .order('created_at DESC')
    elsif params[:search_query]
      @posts = Post.search(params[:search_query])
                   .paginate(page: params[:page], per_page: 3)
                   .order('created_at DESC')
    else
      @posts = Post.paginate(page: params[:page], per_page: 3)
                   .order('created_at DESC')
    end

    @post = Post.new
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.js
      else
        format.js { render js: 'alert("Please fill out all fields!");' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:author,:title, :content, :all_tags, :slug)
  end
end
