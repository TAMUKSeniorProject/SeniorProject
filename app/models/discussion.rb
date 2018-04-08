class Discussion < ApplicationRecord
    belongs_to :channel
    belongs_to :user
    has_many :replies, dependent: :destroy
    
    # You cannot submit a discussion post without having the title and content be filled
    validates :title, :content, presence: true
    resourcify
    
    TOPICS = ['Personal Ad', 'Club Meeting', 'Free Food', 'Food Sale', 'Bake Sale', 'Roommate']
    acts_as_taggable
    acts_as_taggable_on :topics
end
