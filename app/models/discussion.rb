class Discussion < ApplicationRecord
    belongs_to :channel
    belongs_to :user
    has_many :replies, dependent: :destroy
    has_many :taggings
    has_many :tags, through: :taggings
    
    # You cannot submit a discussion post without having the title and content be filled
    validates :title, :content, presence: true
    resourcify
    
    def all_tags=(names)
        self.tags = names.split(",").map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
    end
    
    def all_tags
        self.tags.map(&:name).join(", ")
    end
    
    def self.tagged_with(name)
        Tag.find_by_name!(name).discussions
    end
end
