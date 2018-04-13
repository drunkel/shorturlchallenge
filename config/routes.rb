Rails.application.routes.draw do
  get '/:short_url', to: 'short_urls#show'
end
