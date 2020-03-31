# each review can only belong to one champion and one user

class Review < ApplicationRecord
    belongs_to :champion
    belongs_to :user
end
