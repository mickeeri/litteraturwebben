Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'password_reset/new'

  get 'password_reset/edit'

  get 'articles/destroy'

    # Books
    get 'books/index'
    get 'books/show'
    get 'books/new'
    get 'books/edit'
    get 'books/delete'
    get 'books/add_author_path'

    # Author
    get 'authors/index'
    get 'authors/show'
    get 'authors/new'
    get 'authors/edit'
    get 'authors/delete'


    get 'sessions/new'

    get 'users/new'

    get     'help'      => 'static_pages#help'
    get     'about'     => 'static_pages#about'
    get     'contact'   => 'static_pages#contact'
    get     'signup'    => 'users#new'
    get     'login'     => 'sessions#new'
    post    'login'     => 'sessions#create'
    delete  'logout'    => 'sessions#destroy'


    get     'newbook'   => 'books#new'
    get     'newauthor' => 'authors#new'





    # get     'articles/destroy'

    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    root 'static_pages#home'

    # Example of regular route:
    #   get 'products/:id' => 'catalog#view'

    # Example of named route that can be invoked with purchase_url(id: product.id)
    #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

    # Example resource route (maps HTTP verbs to controller actions automatically):
    resources :users

    resources :books do
        collection do
            get 'search'
        end


        # collection do
        #     get 'genre'
        # end



        resource :articles

        # collection do
        #     get 'latest'
        # end
    end

    resources :authors do
        collection do
            get 'search'
        end

        resource :articles


    end

    resources :password_resets, only: [:new, :create, :edit, :update]

    resources :articles, only: [:new, :create, :edit, :update, :destroy]


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
