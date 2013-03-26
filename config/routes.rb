DanielpuglisiCom::Application.routes.draw do

  # Post.all.each do |article|
  #   if article.permalink
  #     get article.permalink, to: redirect()
  #   end
  # end

  # Home
  root :to => "pages#home"

  # Work
  get "/work" => "pages#work"

  # Blog
  get "/articles" => "posts#index"
  get "/articles/:year/:month(/:day)/:id" => "posts#show", as: :post,
    year:   /(19|20)\d{2}/,
    month:  /[01]?\d/,
    day:    /[0-3]?\d/
end
