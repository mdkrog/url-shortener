class UrlSanitizer
  def self.sanitize(url)
    url.strip!
    sanitized_url = url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    sanitized_url.slice!(-1) if sanitized_url[-1] == "/"
    sanitized_url = "http://#{sanitized_url}"
  end
end