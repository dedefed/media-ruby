class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :category_parents, :foreign_key => :parent_id
  has_many :children, :through => :category_parents, :source => :child
  validates :name, presence: true, length: {minimum:3, maximum: 50}, uniqueness: true
end
