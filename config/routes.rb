Warehouse::Application.routes.draw do
  get "home/" => 'home#login'
  post "home/"=>'home#loginCheck'

  get "inventory_operation/"=>'inventory_operation#default'
  get "inventory_operation/purchase"=>'inventory_operation#purchase'
  post "inventory_operation/purchase"=>'inventory_operation#purchase_action'
  get "inventory_operation/sale"=>'inventory_operation#sale'
  post "inventory_operation/sale"=>'inventory_operation#sale_action'

  get "main"=>'main#index'
  get "main/list"=>'main#index'
  get "main/edit"=>'main#edit'

  get "stats/"=>'stats#default'
  get "stats/amount/"=>'stats#amountStats'
  get "stats/amount/:period"=>'stats#amountStats'
  get "stats/frequency/"=>'stats#frequencyStats'
  get "stats/frequency/:period"=>'stats#frequencyStats'
  get "stats/speed/"=>'stats#speed'
  get "stats/daily/:period"=>'stats#daily'

  get "items/:id/show_by_date"=>'items#show_by_date'
  get "items/:id/test"=>'items#test'
  get "item/item_code"=>'items#search_by_item_code'
  get "item/search_name"=>'items#rough_search'
  get "item/search_price"=>'items#search_price'


  resources :users
  resources :brands
  resources :types
  resources :items



  root "home#login"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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