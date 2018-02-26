Rails.application.routes.draw do
  
  root to: 'pages#home'
  #change default controller to one written in registrations_controller.rb
  devise_for :users, controllers: {registrations: 'registrations'}
end
 