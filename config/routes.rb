DanielpuglisiCom::Application.routes.draw do

  scope "(:locale)", locale: /de|en/ do
    # Home
    root :to => "pages#home"
  end

  devise_for :users

  # Backend
  namespace "admin" do
    get "/", to: "posts#index"
    resources :posts, path: "articles", except: [:show]
    resources :links, except: [:show]
    post "/links/sort", to: "links#sort"
    resources :issues, except: [:show] do
      get "/import_delicious", to: "issues#import_from_delicious"
    end
  end

  # Work
  get "/work", to: "pages#work"
  get "/recommendations", to: "pages#recommendations"

  # Posts Redirects
  get "/articles(/:year(/:month(/:day)))/friday-is-webday-issue-:id", to: redirect{ |p, req| "/fridayiswebday/issues/#{p[:id]}" }

  # Posts
  get "/blog", to: redirect("/articles")
  get "/articles", to: "posts#index"
  get "/articles(/:year(/:month(/:day)))/:id", to: "posts#show", as: :post,
    year:   /(19|20)\d{2}/,
    month:  /[01]?\d/,
    day:    /[0-3]?\d/

  # Archive
  get "/archive", to: "posts#archive"

  # Tags
  get "/tags/:id", to: "posts#tags", as: :tag

  # Links
  scope "fridayiswebday" do
    get "/", to: "links#index", as: :links
    get "/subscribe", to: "subscriptions#new", as: :new_subscription
    post "/subscribe", to: "subscriptions#create", as: :subscription
    get "/confirm", to: "subscriptions#confirm", as: :confirm_subscription
    get "/example", to: "subscriptions#example", as: :example_issue
    get "/issues", to: "issues#index"
    get "/issues/:number", to: "issues#show", as: :issue
  end

  # Sitemap
  get "/sitemap.:format", to: "pages#sitemap"
end
