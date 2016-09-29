class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_title, :against => :title
  self.per_page = 10
  mount_uploader :post_image, PostImageUploader
end
