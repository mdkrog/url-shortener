require 'rails_helper'

RSpec.describe 'Short URL API', type: :request do
  describe 'GET /' do
    it 'redirects to the url stored in cache' do
      get '/'
      # shall change this to a 301 redirect
      expect(response).to have_http_status(200)
    end

    # it should respond with 404 if no shortened url found in cache
  end
end