DanielpuglisiCom::Application.routes.draw do

  scope "(:locale)", locale: /de|en/ do
    # Home
    root :to => "pages#home"
  end

  devise_for :users

  # Backend
  namespace "admin" do
    resources :posts, path: "articles", except: [:show]
  end

  # Work
  get "/work", to: "pages#work"
  get "/recommendations", to: "pages#recommendations"

  # Posts
  get "/blog", to: redirect("/articles")
  get "/articles", to: "posts#index"
  get "/articles/:year/:month(/:day)/:id", to: "posts#show", as: :post,
    year:   /(19|20)\d{2}/,
    month:  /[01]?\d/,
    day:    /[0-3]?\d/

  # Archive
  get "/archive", to: "posts#archive"

  # Tags
  get "/tags/:id", to: "tags#show", as: :tag

  # Sitemap
  get "/sitemap.:format", to: "pages#sitemap"
end
