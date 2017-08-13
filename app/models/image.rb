class Image < ApplicationRecord
  belongs_to :user

  def self.search(query)
    Unsplash::Photo.search(query, page = 1, per_page = 20)
  end
end
