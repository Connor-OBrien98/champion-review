class Review < ApplicationRecord
    belongs_to :champion
    belongs_to :user
end
