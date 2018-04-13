# Service that handles saving ShortUrls.
# Handles the case of collisions in the actual
# shortened urls.
class ShortUrlPersistenceService
  # How many times we should retry during collisions
  MAX_ATTEMPS = 5

  attr_reader :errors

  def initialize(short_url)
    @short_url = short_url
    @errors = []
  end

  # Attempt to save the ShortUrl and handle case of collisions
  def save!
    attemps = 0
    begin
      @short_url.save!
    rescue ActiveRecord::RecordNotUnique => e
      raise e if attemps >= MAX_ATTEMPS

      # If we have retries left, clear the short_url
      # on the object and re-attempt save.
      # Model will re-generate a short_url
      attemps += 1
      @short_url.short_url = nil
      retry
    rescue StandardError => e
      @errors << e.message
    end
  end
end
