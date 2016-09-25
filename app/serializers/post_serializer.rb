class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :username
end
