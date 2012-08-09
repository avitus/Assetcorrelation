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
  match '/user_csdl'           => 'users#custom_csdl',          :as => 'user_csdl'

  # old routes
  match 'user/enter_time_corr'         => 'correlation#time'
  match 'user/correlations/(:id)'      => 'correlation#correlations'
  match 'user/bonds/(:id)'             => 'correlation#bonds'
  match 'user/sectors/(:id)'           => 'correlation#sectors'
  match 'user/countries/(:id)'         => 'correlation#countries'
  match 'user/simple_asset_allocation' => 'home#index'   # page no longer exists


end
