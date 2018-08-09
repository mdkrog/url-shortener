Rails.application.routes.draw do
  get '/:short_url', to: 'short_urls#show'
  post '/', to: 'short_urls#create'
end
