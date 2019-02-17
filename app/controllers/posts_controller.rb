    class PostsController < ApplicationController
        before_action :load_post, only: [:edit, :show]
        before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
        before_action :load_user

        def index
            @posts = Post.all.order('created_at DESC');
        end
    
        def new
            @post = Post.new
        end
    
        def create 
            @post = @user.posts.create(get_params)
            if @post.valid? 
                redirect_to posts_path
            else
                render 'new'
            end
        end
    
        def show
          load_post
        end
    
        def update
            @post = @user.posts.update(params[:id], get_params)
            if @post.valid? 
                redirect_to user_path(current_user)
            else
                render 'new'
            end
        end
    
        def destroy
            @post = Post.find(params[:id])
            @post.destroy
            redirect_to user_path
        end
    
        def load_post
            @post = Post.find(params[:id])
        end
    
        def load_user
            @user = current_user
        end

        def get_params
          post_params = params.require(:post).permit(:title, :lead, :content, :image)
        end
    end
    
