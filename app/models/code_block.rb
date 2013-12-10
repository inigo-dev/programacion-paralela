class CodeBlock < ActiveRecord::Base
  belongs_to :post 
  validates :name, :content, :post_id, presence: true
end
