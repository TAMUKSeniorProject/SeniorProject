Rails.application.routes.draw do
  get 'conversations/_conversation'
  get 'conversations/_messages'
  get 'conversations/_form'
  get 'mailbox/_folder_view'
  get 'mailbox/_folders'
  get 'mailbox/folder_view'
  get 'mailbox/trash'
  get 'mailbox/sent'
  get 'mailbox/inbox'
  


  #discussion categories
  resources :channels
  #used to get a nested view of replies(comments) within a discussion(forum thread).
  resources :discussions do
    resources :replies
  end
    
    resources :notifications do
      collection do
        post :mark_as_read
      end
    end
    
    resources :conversations do
      member do
        post :reply
        post :trash
        post :untrash
      end
  end
  
  get 'tags/:tag', to: 'discussions#index', as: :tag
  
  
  root to: 'pages#home'
  #change default controller to one written in registrations_controller.rb
  devise_for :users, controllers: {registrations: 'registrations'}
  
  get 'calendar' => 'calendar#index'
  get 'moderation' => 'moderation#index'
end
 