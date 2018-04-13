# Service that handles creating new ShortUrls.
# Handles the case of collisions in the actual
# shortened urls.
# Returns the new short_url
class ShortUrlPersistenceService
  # How many times we should retry during collisions
  MAX_ATTEMPS = 5

  attr_reader :errors

  def initialize(url)
    @url = url
    @errors = []
  end

  # Attempt to save the ShortUrl and handle case of collisions
  def save!
    unless valid_url?(@url)
      @errors << 'Invalid URL'
      return
    end

    attemps = 0
    short_url = ShortUrl.new(original_url: @url)
    begin
      short_url.save!
      short_url
    rescue ActiveRecord::RecordNotUnique => e
      raise e if attemps >= MAX_ATTEMPS

      # If we have retries left, re-initialize model.
      # Model will re-generate a short_url
      attemps += 1
      short_url = ShortUrl.new(original_url: @url)
      retry
    rescue StandardError => e
      @errors << e.message
    end
  end

  private

  def valid_url?(uri)
    uri = URI.parse(uri)
    uri.host.present?
  rescue URI::InvalidURIError
    false
  end
end
