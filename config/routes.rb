Assetcorrelation::Application.routes.draw do

  resources :subscriptions

  resources :plans

  devise_for :users
  
  resources :users, :only => :show
  resources :macrovals
  resources :positions
  resources :price_quotes
  resources :securities
  resources :portfolios

  authenticated :user do
    root 'portfolios#index', as: :authenticated_root
  end
  root "home#index"

	mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get '/majors/(:id)'        => 'correlation#correlations',   :as => 'majors'
  get '/bonds/(:id)'			   => 'correlation#bonds',   			  :as => 'bonds'
  get '/sectors/(:id)' 			 => 'correlation#sectors',   		  :as => 'sectors'
  get '/international/(:id)' => 'correlation#countries',      :as => 'international'
  get '/custom'              => 'correlation#custom',         :as => 'custom'
  get '/time'                => 'correlation#time',           :as => 'time'
  get '/corr_over_time'      => 'correlation#corr_over_time', :as => 'corr_over_time'

	get '/primer'              => 'info#primer',							  :as => 'primer'
	get '/support'				     => 'info#support',							  :as => 'support'
	
  get '/shiller_dash'        => 'macrovals#dashboard',        :as => 'shiller_dash'
  get '/calc_shiller'        => 'macrovals#calculate_cols',   :as => 'calc_shiller'
	
	get '/valid_security'		   => 'securities#valid_security',  :as => 'valid_security'
	
	get '/account'             => 'users#show',                 :as => 'account'
  get '/user_csdl'           => 'users#custom_csdl',          :as => 'user_csdl'

  get '/payment'             => 'subscriptions#payment',      :as => 'payment'

  # old routes
  get 'user/enter_time_corr'         => 'correlation#time'
  get 'user/correlations/(:id)'      => 'correlation#correlations'
  get 'user/bonds/(:id)'             => 'correlation#bonds'
  get 'user/sectors/(:id)'           => 'correlation#sectors'
  get 'user/countries/(:id)'         => 'correlation#countries'
  get 'user/simple_asset_allocation' => 'home#index'   # page no longer exists


end
