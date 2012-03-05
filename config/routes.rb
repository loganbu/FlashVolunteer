Flashvolunteer::Application.routes.draw do
    devise_for :users, :module => "users"

    devise_scope :user do
        root :to => "users#index"
        put "confirm_account", :to => "users/confirmations#confirm_account"
        get "users/sign_up/quick", :to => "users/registrations#quick", :as => "quick_new_user"
    end

    resources :users, :only => [:index, :show, :edit, :update] do
        member do
            # My events
            # past/upcoming/recommended
            resource :events, :only => [:show], :controller => "users/events", :as => "events_user"

            resource :privacy, :only => [:show, :update], :controller => "users/privacy", :as => "user_privacy_settings"
            resource :notifications, :only => [:show, :update], :controller => "users/notifications"
        end
        resources :orgs, :only => [:index, :update], :controller => "users/organizations"
    end

    root :to => "users#index"

    resources :neighborhoods, :only => [:index]

    resources :events do
        member do
            resource :register, :only => [:create, :destroy], :controller => "events/register", :as => "register_event"
            get :export
        end
    end
    match "events/in/:neighborhood" => "events#in", :as => 'events_neighborhood', :via => :get

    match "privacy" => "home#privacy"
    match "tou" => "home#tou"
    match "about" => "home#about"
    match "partners" => "home#partners"
    match "help" => "home#help"
    match "donate" => "home#donate"
  
end
