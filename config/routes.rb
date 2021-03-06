ActionController::Routing::Routes.draw do |map|
  map.resources :locations

  map.resources :products

  map.resources :shops

  map.mark_it_up_preview "mark_it_up/preview", :controller => "mark_it_up", :action => "preview"
    

  map.sitemap 'robots.txt', :controller => 'sitemap', :action => 'robots'
  map.sitemap 'sitemap.xml', :controller => 'sitemap', :action => 'sitemap'
  
  map.elements_by_tag "elements/tag/:by_tag", :controller => :elements
  map.elements_by_type "elements/type/:by_type", :controller => :elements

  map.devise_for :users, 
    :path_names => { 
      #:sign_in => 'login', 
      #:sign_out => 'logout', 
      #:password => 'secret', 
      #:confirmation => 'verification', 
      #:unlock => 'unblock'
    }

  map.resources :galleries, :has_one => :element
  map.resources :paragraphs, :has_one => :element
  map.resources :domains, :has_one => :element
  map.resources :pages, :has_one => :element
  map.resources :pictures, :has_one => :element
  
  map.resources :elements, :collection => { :new_element_attachable_from_params => [:post,:get] } do |elements|
    elements.resource :gallery
    elements.resource :picture
    elements.resource :page
    elements.resource :domain
  end
  
  map.tree "tree/:action", :controller => :tree

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
