Rails.application.routes.draw do
  devise_for :users

  root "assets#index"
  # Routes for the Trade resource:

  # CREATE
  post("/insert_trade", { :controller => "trades", :action => "create" })
          
  # READ
  get("/trades", { :controller => "trades", :action => "index" })
  
  get("/trades/:path_id", { :controller => "trades", :action => "show" })
  
  # UPDATE
  
  post("/modify_trade/:path_id", { :controller => "trades", :action => "update" })
  
  # DELETE
  get("/delete_trade/:path_id", { :controller => "trades", :action => "destroy" })

  #------------------------------

  # Routes for the Asset resource:

  # CREATE
  post("/insert_asset", { :controller => "assets", :action => "create" })
          
  # READ
  get("/assets", { :controller => "assets", :action => "index" })
  
  get("/assets/:path_id", { :controller => "assets", :action => "show" })
  
  # UPDATE
  
  post("/modify_asset/:path_id", { :controller => "assets", :action => "update" })
  
  # DELETE
  get("/delete_asset/:path_id", { :controller => "assets", :action => "destroy" })

  #------------------------------

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
