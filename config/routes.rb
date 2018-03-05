Rails.application.routes.draw do
  #discussion categories
  resources :channels
  get 'conversations/newc'

  get 'messages/new'

  get 'conversations/show'

  get 'conversations/new'

  #used to get a nested view of replies(comments) within a discussion(forum thread).
  resources :discussions do
    resources :replies
  end
    
    resources :conversations do
    resources :messages
  end
  
  root to: 'pages#home'
  #change default controller to one written in registrations_controller.rb
  devise_for :users, controllers: {registrations: 'registrations'}

end
 