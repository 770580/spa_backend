module Api
  module V2
    class PostsController < ApplicationController
      before_action :authenticate_user

      def index
        post = params['search'] ? Post.search_by_title(params['search']) : Post.all

        if params['sort']
          f = params['sort']
          field = f[0] == '-' ? f[1..-1] : f
          order = f[0] == '-' ? 'DESC' : 'ASC'
          post = post.order("#{field} #{order}") if Post.new.has_attribute?(field)
        end

        post = post.page(params[:page] ? params[:page][:number] : 1)

        render json: post, meta: pagination_meta(post)
      end

      def show
        post = Post.find(params[:id])
        render json: post
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
        params.require(:post).permit(:title, :body, :username, :post_image)
      end

      def pagination_meta(object)
        {
          current_page: object.current_page,
          next_page: object.next_page,
          prev_page: object.previous_page,
          total_pages: object.total_pages,
          total_count: object.total_entries
        }
      end
    end
  end
end
