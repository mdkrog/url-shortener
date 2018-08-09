require 'rails_helper'

RSpec.describe 'Short URL API', type: :request do
  describe 'POST /' do
    it 'creates a new shortened url' do
      headers = { "CONTENT_TYPE": "application/json" }
      post '/', params: '{ "url": "http://www.farmdrop.com" }', headers: headers

      expect(response).to have_http_status(200)
    end

    # it should respond with the { "short_url": "/abc123", "url": "http://www.farmdrop.com" }
    # it should throw error if there is no content type header
  end
end