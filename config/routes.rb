DanielpuglisiCom::Application.routes.draw do

  devise_for :users

  # Backend
  scope "/admin" do
    resources :posts, path: "articles"
  end

  # Home
  root :to => "pages#home"

  # Work
  get "/work", to: "pages#work"

  # Posts
  get "/articles", to: "posts#index"
  get "/articles/:year/:month(/:day)/:id", to: "posts#show", as: :post,
    year:   /(19|20)\d{2}/,
    month:  /[01]?\d/,
    day:    /[0-3]?\d/

  # Archive
  get "/archive", to: "posts#archive"

  # Tags
  get "/tags/:id", to: "tags#show", as: :tag
end
