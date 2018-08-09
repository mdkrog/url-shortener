class DeterministicSquisher
  def self.squash(url, salt)
    url = Digest::MD5.hexdigest(url+"#{salt}").slice(0..5)
  end
end