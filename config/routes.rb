Rails.application.routes.draw do
  get '/:short_url', to: 'short_urls#show'
  get '/', to: 'short_urls#index'
  post '/', to: 'short_urls#create'
end
