Rails.application.routes.draw do
  root to: 'pages#home'
  get 'login', to: 'pages#login'
end
 