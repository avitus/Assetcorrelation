Assetcorrelation::Application.routes.draw do

  devise_for :users
  
  resources :users, :only => :show
  resources :macrovals
  resources :positions
  resources :price_quotes
  resources :securities
  resources :portfolios


  authenticated do
    root      :to => 'portfolios#index'
  end  
  root        :to => 'home#index'  

	mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  match '/majors/(:id)'        => 'correlation#correlations',   :as => 'majors'
  match '/bonds/(:id)'			   => 'correlation#bonds',   			  :as => 'bonds'
  match '/sectors/(:id)' 			 => 'correlation#sectors',   		  :as => 'sectors'
  match '/international/(:id)' => 'correlation#countries',      :as => 'international'
  match '/custom'              => 'correlation#custom',         :as => 'custom'
  match '/time'                => 'correlation#time',           :as => 'time'
  match '/corr_over_time'      => 'correlation#corr_over_time', :as => 'corr_over_time'

	match '/primer'              => 'info#primer',							  :as => 'primer'
	match '/support'				     => 'info#support',							  :as => 'support'
	
  match '/shiller_dash'        => 'macrovals#dashboard',        :as => 'shiller_dash'
  match '/calc_shiller'        => 'macrovals#calculate_cols',   :as => 'calc_shiller'
	
	match '/valid_security'		   => 'securities#valid_security',  :as => 'valid_security'
	
	match '/account'             => 'users#show',                 :as => 'account'

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
