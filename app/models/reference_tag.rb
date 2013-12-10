class ReferenceTag < ActiveRecord::Base
  belongs_to :reference
  belongs_to :tag
  
  validates :reference_id, :tag_id, presence: true
end
