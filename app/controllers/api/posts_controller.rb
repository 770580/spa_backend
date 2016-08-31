module Api
  class PostsController < ApplicationController
    def index
      render json: Post.all
    end

    def create
      post = Post.new(post_params)
      if post.save
        render json: post
      else
        render json: post.errors
      end
    end

    def update
      post = Post.find(params[:id])
      if post.update(post_params)
        render json: post
      else
        render json: post.errors
      end
    end

    def destroy
      post = Post.find(params[:id])
      post.destroy
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, :username)
    end
  end
end
