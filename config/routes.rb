# -*- encoding : utf-8 -*-
Yl::Application.routes.draw do
  themes_for_rails

  constraints(CoSubdomain) do
    root to: "companies#home"
  end
  constraints :subdomain => 'c' do
    root to: "companies#index"
    get '/p-:id' => "companies#province",as: "province"
    resources :companies,path: '' do
      get :all,on: :collection
    end
  end


  get "settings/index"

  resources :shops,path: "yaodian" do
    get "redirect",on: :member
  end


  resources :options


  resources :jibings,:path=>'jibing' do
    member do 
      get 'suggest'
    end
  end

  match "/goto/:class_name/:id"=>'home#goto'
  resources :comments,:only=>%w(index create show)

  resources :entries,:path=>'zhaoshang' do
    collection do 
      get :hot
    end
  end
  match '/archive/:date'=>'home#date',:as=>'date'
  match '/archive'=>'home#archive',:as=>'archive'

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
  resources :chengfens,:path=>'chengfen' , :only=>[:index,:show] do
    get :shouzi,:on=>:collection
  end

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
  get '/profile/edit'=>"users#edit_profile",:as=>'edit_profile'
  put '/profile'=>"users#update_profile",:as=>'update_profile'
  match '/:id/%e8%af%b4%e6%98%8e%e4%b9%a6'=>"drugs#shuomingshu",:as=>"shuomingshu"#,:constraints=>{:id=> /.+%E8%AF%B4%E6%98%8E%E4%B9%A6/}
  match '/:id/%E8%AF%B4%E6%98%8E%E4%B9%A6'=>"drugs#shuomingshu"
  resources :drugs,:path=>'yaopin' do
    collection do
      get :manage
      get :shouzi
      get :search
      get :desc
      get :desc_preview
    end
    member do
      get :pihao
      post :track
      # get :shuomingshu
    end
  end

  match '/bdapp(/:action(/:id))'=>"bdapp"
  match 'sitemap' => 'home#sitemap'
  match 'flush' => 'home#flush'
  match 'index' => 'home#index'
  match 'redirect' => 'home#redirect',as: 'redirect'
  match ':action' => "home",:constraints=>{:action=>/sitemap|flush|souyao|stats|mmseg|test|redirect|chaxun/}
  resque_constraint = lambda do |request|
    Rails.env.development? or 
    (request.env['warden'].authenticate? and
      request.env['warden'].user.has_role?(:admin))
  end
  constraints resque_constraint do
    match '/settings(/:action(/:id))'=>"settings"
    mount Resque::Server.new, :at => "/resque"
  end
  #match '/(ask|wiki)/:id' => "posts#show",as: "po"
  match '/:act/:id' => "posts#show",:constraints=>{:act=>/news|ask|wiki/},as: :po
  #match '/ask/:id' => "posts#show",as: :ask
  #match '/wiki/:id' => "posts#show",as: :wiki

  match '/:id'=>"drugs#show",:as=>"show_yao"

  #match '/:id/说明书'=>"drugs#shuomingshu",:as=>"shuomingshu"#,:constraints=>{:id=> /.+%E8%AF%B4%E6%98%8E%E4%B9%A6/}
  root :to => "home#index"
match "syncs/:type/new" => "syncs#new", :as => :sync_new
match "syncs/:type/callback" => "syncs#callback", :as => :sync_callback

end
