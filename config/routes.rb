Flashvolunteer::Application.routes.draw do
    devise_for :users, :module => "users"

    devise_scope :user do
        root :to => "users#index"
        put "confirm_account", :to => "users/confirmations#confirm_account"
        get "users/sign_up/quick", :to => "users/registrations#quick", :as => "quick_new_user"
    end

    # 
    # Index - Show all users?
    # Show - Timeline
    # Edit - Change profile
    # Update - Actually updating it
    resources :users, :only => [:index, :show, :edit, :update] do
        member do
            # My events
            # past/upcoming/recommended
            resource :events, :only => [:show], :controller => "users/events", :as => "events_user"

            # Change privacy settings
            resource :privacy, :only => [:show, :update], :controller => "users/privacy", :as => "user_privacy_settings"

            # Change notification settings
            resource :notifications, :only => [:show, :update], :controller => "users/notifications"

            # Switch user login
            get :switch
        end

        # 
        # Show - List organizations you're part of
        # Update - Remove?
        resources :orgs, :only => [:index, :update], :controller => "users/organizations"
    end

    resources :new_user_wizard, :only => [:show, :update], :controller => "users/new_user_wizard"
    resources :new_org_wizard, :only => [:show, :update], :controller => "orgs/new_org_wizard"
    root :to => "users#index"

    resources :neighborhoods, :only => [:index]

    #
    # Index - Show all orgs?
    # Show - Timeline
    # Edit - Change profile
    # Update - Actualy update profile
    resources :orgs, :only => [:index, :show, :edit, :update] do
        # Private parts, available to current signed-in org
        member do
            # Show organization past/upcoming events
            resource :events, :only => [:show], :controller => "orgs/events", :as => "events_org"

            # Show admins of the org
            resource :stats, :only => [:show], :controller => "orgs/stats", :as => "org_stats"

            # Show admins of the org
            resource :admins, :only => [:show, :update], :controller => "orgs/admins", :as => "org_admins"
        end
    end
    
    # Search for people
    resources :people, :only => [:index]

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
