# -*- encoding : utf-8 -*-
Yl::Application.routes.draw do

  resources :posts,:path=>"news"

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "tools/adsense"
  get "tools/adsense_preview"
  match '/gad'=>'tools#adsense'

  resources :links do
    collection do
      get :manage
    end
  end

  match '/category/:category_id'=>'drugs#category',:as=>"category"
  resources :chengfens,:path=>'chengfen' , :only=>[:index,:show]

  resources :categories do
    collection do
      get :manage
    end
  end

  # match '/chengfen/:name'=>"yaopins#chengfen",:as=>"chengfen"



  # match '/yaoming/:name'=>"yaopins#name",:as=>"name"
  match '/jixing/:jixing'=>"yaopins#jixing",:as=>"jixing"
  match '/leibie/:leibie'=>"yaopins#leibie",:as=>"leibie"
  resources :yaopins,:path=>'pihao' do
    collection do
      get :manage
      get :auto_complete
      get :search
      get :map
    end
    member do
      post :track
    end
  end

  # authenticated :user do
    # root :to => 'home#index'
  # end

  devise_for :users
  resources :users, :only => [:show, :index]
  match '/:id/%e8%af%b4%e6%98%8e%e4%b9%a6'=>"drugs#shuomingshu",:as=>"shuomingshu"#,:constraints=>{:id=> /.+%E8%AF%B4%E6%98%8E%E4%B9%A6/}
  match '/:id/%E8%AF%B4%E6%98%8E%E4%B9%A6'=>"drugs#shuomingshu"
  resources :drugs,:path=>'yaopin' do
    collection do
      get :manage
    end
    member do
      get :pihao
      post :track
      # get :shuomingshu
    end
  end

  match '/bdapp(/:action(/:id))'=>"bdapp"
  #match 'test' => 'home#test'
  match '/:id'=>"drugs#show",:as=>"show_yao"

  #match '/:id/说明书'=>"drugs#shuomingshu",:as=>"shuomingshu"#,:constraints=>{:id=> /.+%E8%AF%B4%E6%98%8E%E4%B9%A6/}
  root :to => "home#index"
match "syncs/:type/new" => "syncs#new", :as => :sync_new
match "syncs/:type/callback" => "syncs#callback", :as => :sync_callback

end
