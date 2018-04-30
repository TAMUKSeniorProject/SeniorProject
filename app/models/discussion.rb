class Discussion < ApplicationRecord
    #include PgSearch
    belongs_to :channel
    belongs_to :user
    has_many :replies, dependent: :destroy
    has_many :users, through: :replies
    
    # You cannot submit a discussion post without having the title and content be filled
    validates :title, :content, presence: true
    resourcify
    
    TOPICS = ['Club Meeting', 'Free Food', 'Food Sale', 'University Event', 'Extra-Credit', 'Job-Related', 'Info-Session','Other']
    acts_as_taggable
    acts_as_taggable_on :topics
    #pg_search_scope :quick_search, against: [:title, :content], associated_against: {topics: [:name]}
end
