class ShortUrl < ApplicationRecord
  validates :original_url, presence: true
  # Length 4 is arbitrary for this project. In a real worl scenario
  # we would want more research into an optimal length.
  validates :short_url, length: { is: 4 }

  before_validation :generate_short_url

  private

  # Generates a 'random' 4 chracter hex string for short_url
  # Not collision safe, so be sure to check for those.
  def generate_short_url
    return if self.short_url.present?
    self.short_url = SecureRandom.hex(2)
  end

end
