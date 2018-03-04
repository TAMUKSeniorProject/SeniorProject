class Reply < ApplicationRecord
    belongs_to :discussion
    belongs_to :user
    
    validation :content, presence: true
end
