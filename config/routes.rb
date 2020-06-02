Rails.application.routes.draw do
    get '/' => 'home#top'
    post "home/check" => "home#check"
    get "home/check" => "home#check"

    mount API::Root => "/"
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end