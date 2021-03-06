Rails.application.routes.draw do

  resources :admin_shifts
  resources :sales_admins

  resources :production_rates
  resources :material_theoreticals
  resources :theoreticalcategories
  resources :material_theoreticalcategories

  resources :lookup_prices

  resources :sold_panels
  resources :buyer_phones
  resources :buyers

  post '/shifts/startshift', to: 'shifts#startshift'
  get '/shifts/showstartshift', to: 'shifts#showstartshift'
  post '/shifts/:id/endshift', to: 'shifts#endshift'
  get '/shifts/showendshift', to: 'shifts#showendshift'
  get '/shifts/currentshift', to: 'shifts#currentshift' 
  get '/shifts/allshifts', to: 'shifts#allshifts'




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
  post 'production_shifts/accept' =>'production_shifts#accept'
  post 'employees/fire'=> 'employees#fire'
  post 'employees/search'=> 'employees#search' 
 
  post 'sales_admins/accept'=> 'sales_admins#accept' 
  post 'admin_shifts/accept'=> 'admin_shifts#accept'

  get 'material' => 'materials#report'

  post 'forget_password' => 'sessions#forget_password'
  get 'forget_password' => 'sessions#forget_password_form'



  post 'delPhon' => 'employees#pho'
  post 'delPhonee' => 'buyers#pho'
  post 'vendors/black' =>'vendors#black'

  post 'materialvendorcreate' => 'vendors#materialvendorcreate'
  post 'machinecreate' => 'machines#machinecreate'
  post 'notification' => 'admin_shifts#notification'
  post 'adminnotification' => 'sales_admins#adminnotification'
  
  get '*url' => 'errors#routing'
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
