class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :username, :post_image, :created_at
end
