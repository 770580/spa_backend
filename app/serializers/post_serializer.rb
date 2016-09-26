class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :username, :created_at
end
