class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
         
  has_many :discussions, dependent: :destroy
  has_many :channels, through: :discussions
  
  acts_as_messageable
  
  def mailboxer_name
    username
  end
  
  def mailboxer_email(object)
    self.email
  end
  
end
