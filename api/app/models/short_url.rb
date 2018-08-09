class ShortUrl
  attr_accessor :url_sanitizer, :url_squisher

  def initialize(url_sanitizer: UrlSanitizer, url_squisher: DeterministicSquisher)
    @url_sanitizer = url_sanitizer
    @url_squisher = url_squisher
  end

  def call(url)
    salt = 0
    sanitized_url = url_sanitizer.sanitize(url)
    short_url = url_squisher.squash(sanitized_url, salt)

    while collision_occurs?(short_url, sanitized_url)
      salt += 1
      short_url = url_squisher.squash(sanitized_url, salt)
    end

    store_url(short_url, sanitized_url)
    return short_url
  end

  private

  def collision_occurs?(short_url, sanitized_url)
    Rails.cache.exist?(short_url) && Rails.cache.read(short_url) != sanitized_url
  end

  def store_url(short_url, sanitized_url)
    Rails.cache.write(short_url, sanitized_url)
  end
end