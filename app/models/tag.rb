class Tag < ApplicationRecord
    has_many :taggings
    has_many :discussions, through: :taggings
end
