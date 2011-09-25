Assetcorrelation::Application.routes.draw do
	
  resources :macrovals
  resources :positions
  resources :price_quotes
  resources :assets
  resources :portfolios

  #get \"users\/show\"

  root :to => "home#index"

  devise_for :users
  resources :users

	mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  match '/majors'				 	=> 'correlation#correlations',  :as => 'majors'
  match '/bonds' 					=> 'correlation#bonds',   			:as => 'bonds'
  match '/sectors' 				=> 'correlation#sectors',   		:as => 'sectors'
  match '/international'  => 'correlation#countries',     :as => 'international'
  match '/custom'         => 'correlation#custom',        :as => 'custom'

	match '/primer'					=> 'info#primer',								:as => 'primer'
	match '/support'				=> 'info#support',							:as => 'support'
	
  match '/shiller_dash'   => 'macrovals#dashboard',       :as => 'shiller_dash'
  match '/calc_shiller'   => 'macrovals#calculate_cols',  :as => 'calc_shiller'
	
	match '/valid_asset'		=> 'assets#valid_asset',				:as => 'valid_asset'
	

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
  # match ':controller(/:action(/:id(.:format)))'
end
