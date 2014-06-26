Stratus::Application.routes.draw do

  resources :refreshes do
    member do
      get 'complete'
      get 'terminate'
    end
  end


  resources :flows


  resources :flow_parts


  resources :retries


  resources :deployment_requests do
    member do
      get 'show_deployment_reference'
    end
  end


  resources :approved_builds


  resources :deployment_plans


  resources :jump_page_links


  resources :deployment_sets


  resources :auth_keys


  resources :role_sync_jobs do
    member do
      get 'start'
    end
  end


  resources :server_sync_jobs do
    member do
      get 'start'
    end
  end


  resources :application_sync_jobs do
    member do
      get 'start'
    end
  end


  resources :sync_jobs


  resources :esr_works


  resources :environment_sync_reports do
    member do
      get 'start'
      get 'rerun'
      get 'correct'
    end
  end

  get "searcher/index"

  resources :latest_releases


  resources :app_sync_reports


  get "applications_servers_sync_report/index"

  get "applications_sync_report/index"

  resources :checkout_result_details


  resources :checkout_results do
    member do
      get 'start'
    end
  end

  resources :icons

  resources :useful_links

  resources :groups

  devise_for :users 

  resources :users do
    member do
      get 'refresh_token'
    end
  end

  resources :system_configurations

  require 'sidekiq/web'

  resources :run_logs

  resources :servers do
    member do
      get 'clear_logs'
      get 'restart_tomcat'
    end
  end

  resources :applications

  resources :suggestions

  resources :users

  resources :switches do
    member do
      get 'accept'
      get 'start'
      get 'complete'
      get 'terminate'
      get 'clone'
      get 'reject'
      get 'proceed'
    end
    collection do
      get 'multinew'
      post 'multicreate'
    end  
  end

  resources :mail_recipients

  resources :deployments do
    member do
      get 'accept'
      get 'start'
      get 'complete'
      get 'terminate'
      get 'reject'
      get 'clone'
      get 'rollback'
      get 'promote'
      get 'proceed'
      get 'approve'
      get 'get_help'
    end
    collection do
      get 'rollup'
    end
  end

  resources :chores

  get "welcome/index"
  get "config_tools/refresh_servers"

  resources :roles

  resources :environments

  resources :reload_requests do
    member do
      get 'accept'
      get 'complete'
      get 'reject'
    end
  end

  mount Sidekiq::Web, at: "/sidekiq"


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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
