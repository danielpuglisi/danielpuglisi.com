DanielpuglisiCom::Application.routes.draw do

  # Home
  root :to => "pages#home"

  # Work
  get "/work" => "pages#work"

  # Blog
  get "/articles" => "posts#index"
  get "/articles/:id" => "posts#show", as: :post
end
