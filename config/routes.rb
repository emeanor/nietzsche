Rails.application.routes.draw do

  root to: 'main#index'
  
  resources :texts, only: [:index, :show], param: :url_slug

  resources :editions do
    get 'books', to: 'editions#show'

    resources :books, except: [:index], param: :position do
      get 'chapters', to: 'books#show'

      resources :chapters, except: [:index], param: :position
    end
  end

end
