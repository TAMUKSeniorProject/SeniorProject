Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  mount Thredded::Engine => '/forum'
end
 