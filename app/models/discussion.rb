class Discussion < ApplicationRecord
    #include PgSearch
    belongs_to :channel
    belongs_to :user
    has_many :replies, dependent: :destroy
    has_many :users, through: :replies
    
    has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    
    # You cannot submit a discussion post without having the title and content be filled
    validates :title, :content, presence: true
    resourcify
    
    TOPICS = ['Club Meeting', 'Free Food', 'Food Sale', 'University Event', 'Extra-Credit', 'Job-Related', 'Info-Session','Other']
    acts_as_taggable
    acts_as_taggable_on :topics
    #pg_search_scope :quick_search, against: [:title, :content], associated_against: {topics: [:name]}
end
