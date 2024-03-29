class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_blog_post, except: [:index, :new, :create] # only: [:show, :edit, :update, :destroy]
    before_action :find_blog_post, only: [:show, :edit, :update, :destroy, :like, :dislike]

  def index
    @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
    @pagy, @blog_posts = pagy(@blog_posts)
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    authorize_admin!
    @blog_post = BlogPost.find(params[:id])
  end
  
  def update
    authorize_admin!
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_admin!
    @blog_post.destroy
    redirect_to root_path
  end

  def like
    @blog_post = BlogPost.find(params[:id])
    @blog_post.liked_by current_user
    redirect_back fallback_location: root_path
  end

  def dislike
    @blog_post = BlogPost.find(params[:id])
    @blog_post.disliked_by current_user
    redirect_back fallback_location: root_path
  end

  private #helper method
  
  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :cover_image, :published_at)
  end

  def set_blog_post
    # if user_signed_in?
    #   @blog_post = BlogPost.find(params[:id])
    # else
    #   @blog_post = BlogPost.published.find(params[:id])
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
  end

  # def authorize_user!
  #   redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.user?
  # end

  def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.admin?
  end

  def find_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

end
