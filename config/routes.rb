Trackingspace::Application.routes.draw do

  get "ads/new"

  get "ads/create"

  get "ads/edit"

  get "ads/show"

  resources :sitemaps, :only => :index
  match "/sitemap.xml" => 'sitemaps#index', :format => :xml

  resources :sponsors 

  post "sponsors/sendsponsoremail"
  get "sponsors/sendsponsoremail"
  match "sponsors/:id/accept" => 'sponsors#accept', :as => 'acceptsponsor'
  match 'sponsored' => 'pages#sponsored', :as => 'sponsored'

  resources :lease_shares
  match "lease_shares/:id/accept" => 'lease_shares#accept', :as => 'accept_leaseshare'

  resources :subscriptions

  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => 'sessions'}

  resources :users do
      member do
        get :following, :followers, :trackingbuildings, :buildingads, :spaceads, :leases, :showfeed
      end
    end
  
  resources :users, :only => [:index,:show,:upgrade]
  
  match 'auth/:provider/callback' => 'authentications#create'
  
  resources :microposts, :only => [:create,:destroy,:mobile_post]
  resources :user_relationships, :only => [:create,:destroy]
  resources :building_relationships, :only => [:create,:destroy]

  match 'buildings/:building_id/post' => 'microposts#mbuilding_post', :as => 'mbuilding_post'
  match 'buildings/:building_id/spaces/:id/post' => 'microposts#mspace_post', :as => 'mspace_post'

  match 'map' => 'buildings#map'
  match 'home' => 'pages#index', :as => 'home'
  match 'buildingposts' => 'buildings#index', :as => 'buildingposts'
  match 'download' => 'leases#download', :as => 'download'
  match 'privacy' => 'pages#privacy', :as => 'privacy'
  match 'help' => 'pages#help', :as => 'help'
  match 'upgrade' => 'pages#upgrade', :as => 'upgrade'
  match 'early_adopter' => 'pages#earlyadopter', :as => 'earlyadopter'
  match 'learnmore' => 'pages#learnmore', :as => 'learnmore'
  match 'newlearnmore' => 'pages#newlearnmore', :as => 'newlearnmore'
  match 'brokers' => 'pages#brokers', :as => 'brokers'
  match 'upgrade5' => 'pages#upgrade5', :as => 'upgrade5'
  match 'upgrade30' => 'pages#upgrade30', :as => 'upgrade30'
  match 'upgrade100' => 'pages#upgrade100', :as => 'upgrade100'
  match 'upgrade1' => 'pages#upgrade1', :as => 'upgrade1'
  match 'showfollowing' => 'users#showfollowing', :as => 'showfollowing'
  match 'showfollowers' => 'users#showfollowers', :as => 'showfollowers'

  match 'mobilebuilding/:id' => 'buildings#mobile_building_show', :as => 'mobilebuilding'


  resources :authentications

  resources :buildings do
    member do
      get :mapview, :videoview, :spacesview, :newspace, :addvideo, :management, :comingsoon
      put :claimpropmgmt
    end
    resources :spaces
  end

  resources :ads

  match 'commercial_real_estate_lease' => 'pages#spaces_main', :as => 'spaces_main'
  match 'people' => 'pages#people_main', :as => 'people_main'
  match 'commercial_real_estate_properties' => 'pages#buildings_main', :as => 'buildings_main'
  
  resources :spaces do
    resources :leases
  end

  root :to => 'buildings#home'
  #root :to => 'pages#learnmore'
  
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'