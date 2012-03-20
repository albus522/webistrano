Webistrano::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  root :to => 'projects#dashboard', as: :home

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  match ':controller/service.wsdl', :action => 'wsdl'

  resources :hosts
  resources :recipes do
    collection { get :preview }
  end
  resources :projects do
    member { get :dashboard }

    resources :project_configurations

    resources :stages, :member => {} do
      member do
        get   :capfile
        match :recipes
        get   :tasks
      end

      resources :stage_configurations
      resources :roles
      resources :deployments do
        collection { get :latest}
        member     { post :cancel }
      end
    end
  end

  # RESTful auth
  resources :users do
    member do
      get  :deployments
      post :enable
    end
  end
  resources :sessions do
    collection { get :version }
  end
  get   '/signup' => 'users#new'
  get   '/login'  => 'sessions#new'
  match '/logout' => 'sessions#destroy'

  # Install the default route as the lowest priority.
  match ':controller/:action/:id(.:format)'
end
