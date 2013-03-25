DanielpuglisiCom::Application.routes.draw do
  root :to => "pages#home"
  get "/work" => "pages#work"
end
