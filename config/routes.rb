Rails.application.routes.draw do
    get '/' => 'home#top'
    post "home/create" => "home#create"
    get "home/create" => "home#create"

    mount API::Root => "/"
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end