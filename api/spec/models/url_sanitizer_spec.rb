require 'rails_helper'

RSpec.describe UrlSanitizer, type: :model do
  describe "#sanitize" do
    it "does nothing if it's in the correct format" do
      sanitized_url = UrlSanitizer.sanitize("http://farmdrop.com")
      expect(sanitized_url).to eq("http://farmdrop.com")
    end

    it "removes https from a url" do
      sanitized_url = UrlSanitizer.sanitize("https://farmdrop.com")
      expect(sanitized_url).to eq("http://farmdrop.com")
    end

    it "removes www from url" do
      sanitized_url = UrlSanitizer.sanitize("www.farmdrop.com")
      expect(sanitized_url).to eq("http://farmdrop.com")
    end

    it "removes www from url even if http exists" do
      sanitized_url = UrlSanitizer.sanitize("http://www.farmdrop.com")
      expect(sanitized_url).to eq("http://farmdrop.com")
    end

    it "makes url lower case www from url" do
      sanitized_url = UrlSanitizer.sanitize("Farmdrop.com")
      expect(sanitized_url).to eq("http://farmdrop.com")
    end

    it "adds http if it's not there from url" do
      sanitized_url = UrlSanitizer.sanitize("farmdrop.com")
      expect(sanitized_url).to eq("http://farmdrop.com")
    end

    it "removes trailing slashes" do
      sanitized_url = UrlSanitizer.sanitize("farmdrop.com/")
      expect(sanitized_url).to eq("http://farmdrop.com")
    end
  end
end
