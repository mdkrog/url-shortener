require 'rails_helper'

RSpec.describe "Short URL API", type: :request do
  describe "GET /" do
    it "redirects to the url stored in cache" do
      Rails.cache.write("xyz123", "http://www.farmdrop.com")
      get "/xyz123"
      expect(response).to have_http_status(301)
    end

    it "responds with 404 if no shortened url found in cache" do
      get "/abc"
      expect(response).to have_http_status(404)
    end
  end
end