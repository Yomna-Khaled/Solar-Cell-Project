Rails.application.routes.draw do
  post '/shifts/startshift', to: 'shifts#startshift'
  get '/shifts/showstartshift', to: 'shifts#showstartshift'
  post '/shifts/:id/endshift', to: 'shifts#endshift'
  get '/shifts/showendshift', to: 'shifts#showendshift'
 


  resources :categories
  get 'sessions/new'
  get "crews/get_employees"=>"crews#get_employees"
  get "crews/:id/get_employees"=>"crews#get_employees"
  

  resources :vendor_spares

  resources :spare_parts

  resources :shifts
  resources :production_shifts
  resources :employee_managers
  resources :employee_phones
  resources :employees
  resources :crews
  resources :vendor_containers


  resources :solar_panels
  resources :containers
  resources :machines

  resources :material_vendors
 
  resources :vendors do 
	 resources :vendor_phones
  end
  resources :material_properties




  resources :properties
  resources :materials
  resources :quantities

  root 'sessions#new'
  get 'login' => 'sessions#new'
  get 'report' => 'shifts#report'  
  post 'login' => 'sessions#create' 
  delete 'logout' => 'sessions#destroy'
  get '/crew/home' , to: 'crews#home'
  post 'delPhone' => 'vendors#pho'
 
  post 'materialvendorcreate' => 'vendors#materialvendorcreate'
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
