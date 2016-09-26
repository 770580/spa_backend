class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_title, :against => :title
  self.per_page = 2
end
