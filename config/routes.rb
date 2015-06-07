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

  get 'articles/edit'

  get 'sessions/new'

  get 'users/new'

  get     'about'     => 'static_pages#about'
  get     'contact'   => 'static_pages#contact'
  get     'signup'    => 'users#new'
  get     'login'     => 'sessions#new'
  post    'login'     => 'sessions#create'
  delete  'logout'    => 'sessions#destroy'

  # get     'newbook'   => 'books#new'
  get     'newauthor' => 'authors#new'

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :users

  resources :books do
    collection do
      get 'search'
    end

    resource :articles
  end

  resources :authors do
    collection do
      get 'search'
    end

    resource :articles
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :articles
end
