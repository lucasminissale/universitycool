Universitycool::Application.routes.draw do
  
  namespace :admin do
      resources :universities
  end
  
  root :to => 'university_searches#new'
  
  resources :university_searches
  
  match "/about-us", :to => "university_searches#about_us", :as => :about_us
  
  match "/about-site", :to => "university_searches#about_site", :as => :about_site
  
end
