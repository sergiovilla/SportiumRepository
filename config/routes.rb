Sportium::Application.routes.draw do

  get "password_reset/new"

  root :to => 'about#inicio'
  get '/about' => 'about#index', as: 'about'

  match 'catalogo/search' => 'catalog#search', as: 'search'
  match 'catalogo' => 'catalog#index'
  match 'catalogo/Marcas/:nombre' => 'catalog#index_catalogo_marcas', as: 'catalogo_marca'
  match 'catalogo/:tipo' => 'catalog#index_catalogo', as: 'catalogo_tipo' 
  match 'catalogo/show/:id' => 'catalog#show', as: 'catalogo_show'
  match 'catalogo/lista/novedades' => 'catalog#latest', as: 'catalogo_novedades' 
  

  namespace :admin do
    resources :marcas, :tallas, :colors, :ropas
  end

  get 'autocomplete' => 'admin/ropas#autocomplete', as: 'autocomplete_ropa'
  
  post 'admin/order/close'
  get 'admin/order/show'
  match 'admin/order/show/:id' => 'admin/order#show'
  match 'admin/orders' => 'admin/order#index', as: 'admin_orders'

  match 'admin/ropas/new/:tipo' => 'admin/ropas#new', as: 'new_admin_ropa_tipo'
  match 'admin/Administrar' => 'admin/administrar#index', as: 'administrar'

  get 'cart/add'
  post 'cart/add'
  get 'cart/remove'
  post 'cart/remove'
  get 'cart/clear'
  post 'cart/clear'
  
  get 'user_session/new'
  post 'user_session/create'
  get 'user_session/destroy'

  get 'user/new'
  post 'user/create'
  get 'user/show'
  match 'user/show/:id' => 'user#show'
  get 'user/edit'
  post 'user/update'

  get 'checkout/' => 'checkout#index'
  post 'checkout/submit_order'
  get 'checkout/gracias'

  resources :password_reset

  # Rutas del Foro
  get 'foro' => 'foro#index', as: 'foro'
  get 'foro/post' => 'foro#post', as: 'post'
  get 'foro/post/:id' => 'foro#show', as: 'ver_post'
  match 'foro/post/:id/reply' => 'foro#reply', as: 'reply_post'
  post 'foro/create' => 'foro#create', as: 'create_post'
  delete 'foro/post/:id' => 'foro#destroy', as: 'delete_post' 

  # Rutas de tags
  get 'tags' => 'tag#list', as: 'tags' 
  get 'tag/show/:name' => 'tag#show', as: 'show_tag'

  

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
