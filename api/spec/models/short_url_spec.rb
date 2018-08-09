require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe "#call" do
    before(:each) do
      Rails.cache.clear
    end

    it "takes a url and returns a shortened version" do
      url_sanitizer = double('UrlSanitizer', sanitize: "farmdrop.com")
      url_squisher = double('Squisher', squash: "abc123")
      
      shortener = ShortUrl.new(url_sanitizer: url_sanitizer, url_squisher: url_squisher)
      short_url = shortener.call("http://farmdrop.com")
      
      expect(short_url).to eq("abc123")
      expect(url_sanitizer).to have_received(:sanitize)
      expect(url_squisher).to have_received(:squash)
    end
    
    it "stores the short url in the cache" do
      url_sanitizer = double('UrlSanitizer', sanitize: "testing.com")
      url_squisher = double('Squisher', squash: "def456")
      
      shortener = ShortUrl.new(url_sanitizer: url_sanitizer, url_squisher: url_squisher)
      short_url = shortener.call("http://www.testing.com")
      
      expect(Rails.cache.read("def456")).to eq("testing.com")
    end

    context "when collision occurs" do
      it "shortens multiple times if there is a collision" do
        Rails.cache.write("abc", "exists.com")
        url_sanitizer = double('UrlSanitizer', sanitize: "random.com")
        url_squisher = double('Squisher')
        allow(url_squisher).to receive(:squash).and_return('abc', 'def', 'ghi')

        
        shortener = ShortUrl.new(url_sanitizer: url_sanitizer, url_squisher: url_squisher)
        short_url = shortener.call("http://www.random.com")

        expect(Rails.cache.read("abc")).to eq("exists.com")
        expect(Rails.cache.read("def")).to eq("random.com")
        expect(url_squisher).to have_received(:squash).twice
      end

      it "it doesn't shorten multiple times if the same url already exists" do
        Rails.cache.write("abc", "exists.com")
        url_sanitizer = double('UrlSanitizer', sanitize: "exists.com")
        url_squisher = double('Squisher')
        allow(url_squisher).to receive(:squash).and_return('abc', 'def')

        
        shortener = ShortUrl.new(url_sanitizer: url_sanitizer, url_squisher: url_squisher)
        short_url = shortener.call("http://www.exists.com")

        expect(Rails.cache.read("abc")).to eq("exists.com")
        expect(Rails.cache.read("def")).to eq(nil)
        expect(url_squisher).to have_received(:squash).once
      end
    end
  end
end