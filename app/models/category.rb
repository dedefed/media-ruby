class Category < ActiveRecord::Base
  has_ancestry
  has_many :categorizations
  has_many :categories, through: :categorizations
  validates :name, presence: true, length: {minimum:3, maximum: 50}
end
