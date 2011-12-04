Universitycool::Application.routes.draw do
  
  get "pages/index"

  get "universities/index"

  namespace :admin do
    resources :universities
  end
  
  root :to => 'university_searches#new'
  
  resources :universities
  resources :university_searches
  resources :pages
  
  match "/about-us", :to => "university_searches#about_us", :as => :about_us
  
  match "/about-site", :to => "university_searches#about_site", :as => :about_site
  
end
