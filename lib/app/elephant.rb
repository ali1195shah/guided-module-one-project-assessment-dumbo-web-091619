class Elephant < ActiveRecord::Base
    has_many :listings
    has_many :user, through: :listings
end

