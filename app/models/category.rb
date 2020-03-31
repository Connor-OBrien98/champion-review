# each category can have multiple champions 

class Category < ApplicationRecord
    has_many :champions
end
