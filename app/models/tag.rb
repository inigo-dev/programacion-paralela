class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :posts, through: :post_tags
  
  validates :name, presence: true, uniqueness: true
  
  before_save :downcase_name
  
  scope :featured, -> { where(featured: true) }
  
  def self.search(query)
    where("name ILIKE ?", "%#{query}%")
  end
  
  def downcase_name
    self.name = self.name.downcase
  end
  
  
end
