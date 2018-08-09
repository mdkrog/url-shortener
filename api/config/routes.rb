Rails.application.routes.draw do
  get '/', to: 'short_urls#show'
  post '/', to: 'short_urls#create'
end
