class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_title, :against => :title
  mount_uploader :post_image, PostImageUploader
end
