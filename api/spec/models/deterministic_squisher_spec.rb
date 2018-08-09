require 'rails_helper'

RSpec.describe DeterministicSquisher, type: :model do
  describe "#squash" do
    it "takes a url and returns it as a 6 digit string" do
      salt = 0
      short_url = DeterministicSquisher.squash("http://www.framdrop.com", salt)
      
      expect(short_url.length).to eq(6)
    end

    it "is deterministic (using same string and salt produces the same result)" do
      short_url1 = DeterministicSquisher.squash("http://www.framdrop.com", 0)
      short_url2 = DeterministicSquisher.squash("http://www.framdrop.com", 0)
      
      expect(short_url1).to eq(short_url2)
    end

    it "produces different results when using different salts" do
      short_url1 = DeterministicSquisher.squash("http://www.framdrop.com", 0)
      short_url2 = DeterministicSquisher.squash("http://www.framdrop.com", 1)
      
      expect(short_url1).to_not eq(short_url2)
    end
  end
end