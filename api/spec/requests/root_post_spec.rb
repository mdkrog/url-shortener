require 'rails_helper'

RSpec.describe "Short URL API", type: :request do
  describe "POST /" do
    before(:each) do
      Rails.cache.clear
    end

    it "creates a new shortened url" do
      post "/", params: '{ "url": "http://www.farmdrop.com" }', headers: headers

      expect(response).to have_http_status(200)
      expect(response.parsed_body['short_url']).to eq("/0c984e")
      expect(response.parsed_body['url']).to eq("http://www.farmdrop.com")
      expect(Rails.cache.read("0c984e")).to eq("http://farmdrop.com")
    end

    it "should respond with the same short_url even if http is not present" do
      Rails.cache.write("0c984e", "http://farmdrop.com")
      
      post "/", params: '{ "url": "www.farmdrop.com" }', headers: headers

      expect(response.parsed_body['short_url']).to eq("/0c984e")
      expect(response.parsed_body['url']).to eq("www.farmdrop.com")
    end

    def headers
      { "CONTENT_TYPE": "application/json" }
    end
  end
end