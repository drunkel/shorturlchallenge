class ShortUrl < ApplicationRecord
  validates :original_url, presence: true
end
