Rails.application.routes.draw do
  resources :video_statuses

  resources :videos

  resources :contests, constraints: { id: /\d+/}
  resources :users
  resources :clients


  #get 'home/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  post '/login' => 'users#login'
  get '/mycontests' => 'contests#mycontests'
  get '/logout' => 'users#logout'
  post '/uploadvideo' => 'contests#upload_video'
  get '/convert' => 'videos#convert_videos'
  get 'contests/:custom_url' => 'contests#custom_url'

 # get '/contest/new' => 'contest#new'
  #post '/contest/create' => 'contest#create'
  #get '/contest/index' => 'contest#index'
  #get '/contest/me' => 'contest#me'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
