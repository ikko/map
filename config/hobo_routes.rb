# This is an auto-generated file: don't edit!
# You can add your own routes in the config/routes.rb file
# which will override the routes in this file.

Map::Application.routes.draw do


  # Resource routes for controller site_users
  resources :site_users, :only => []


  # Resource routes for controller site_links
  resources :site_links, :only => []


  # Resource routes for controller links
  resources :links, :only => [:index]


  # Resource routes for controller frequent_words
  resources :frequent_words


  # Resource routes for controller sites
  resources :sites, :only => [:index, :show]

  # Owner routes for controller sites
  resources :words, :as => :word, :only => [] do
    resources :sites, :only => [] do
      collection do
        get '/', :action => 'index_for_word'
      end
    end
  end


  # Resource routes for controller reqs
  resources :reqs do
    collection do
      get 'auto'
    end
  end


  # Resource routes for controller word_users
  resources :word_users, :only => []


  # Resource routes for controller site_words
  resources :site_words, :only => []


  # Resource routes for controller users
  resources :users, :only => [:edit, :show, :create, :update, :destroy] do
    collection do
      post 'signup', :action => 'do_signup'
      get 'signup'
    end
    member do
      get 'account'
      put 'reset_password', :action => 'do_reset_password'
      get 'reset_password'
    end
  end

  # User routes for controller users
  post 'login(.:format)' => 'users#login', :as => 'user_login_post'
  get 'login(.:format)' => 'users#login', :as => 'user_login'
  get 'logout(.:format)' => 'users#logout', :as => 'user_logout'
  get 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password'
  post 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password_post'


  # Resource routes for controller words
  resources :words, :only => [:index, :show] do
    collection do
      get 'tree'
    end
  end

  # Owner routes for controller words
  resources :sites, :as => :site, :only => [] do
    resources :words, :only => [] do
      collection do
        get '/', :action => 'index_for_site'
      end
    end
  end

  namespace :concerns do

  end

  namespace :admin do


    # Resource routes for controller admin/users
    resources :users

  end

end
