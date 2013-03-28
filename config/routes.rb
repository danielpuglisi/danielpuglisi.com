DanielpuglisiCom::Application.routes.draw do

  # Home
  root :to => "pages#home"

  # Work
  get "/work" => "pages#work"

  # Posts
  get "/articles" => "posts#index"
  get "/articles/:year/:month(/:day)/:id" => "posts#show", as: :post,
    year:   /(19|20)\d{2}/,
    month:  /[01]?\d/,
    day:    /[0-3]?\d/

  # Archive
  get "/archive", to: "posts#archive"

  # Tags
  get "/tags/:id", to: "tags#show", as: :tag
end
