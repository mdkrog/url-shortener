require 'rails_helper'

RSpec.describe "Short URL API", type: :request do
  describe "POST /" do
    it "creates a new shortened url" do
      skip
      post "/", params: '{ "url": "http://www.farmdrop.com" }', headers: headers

      expect(response).to have_http_status(200)
      expect(response).to eq({ "short_url": "/abc123", "url": "http://www.farmdrop.com" })
    end

    it "should respond with the same short_url even if http is not present" do
      skip
      Rails.cache.write("http://www.farmdrop.com", "abc123")
      
      post "/", params: '{ "url": "www.farmdrop.com" }', headers: headers

      expect(response).to have_http_status(200)
      expect(response).to eq({ "short_url": "/abc123", "url": "http://www.farmdrop.com" })
    end
    
    it "should respond with the same short_url even if http is not present" do
      skip
      post "/", params: '{ "url": "www.farmdrop.com" }'

      expect(response).to have_http_status(400)
      expect(response).to eq({ error: "Please ensure you have a content-type header set to application/json" })
    end

    def headers
      { "CONTENT_TYPE": "application/json" }
    end
  end
end