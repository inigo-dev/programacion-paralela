class Reference < ActiveRecord::Base

  belongs_to :reference_type
  has_many :reference_tags
  has_many :tags, through: :reference_tags
  
  validates :title, :url, :reference_type_id, presence: true
  validates :url, :format => URI::regexp(%w(http https))
  
  mount_uploader :image, ReferenceImageUploader
  
  attr_accessor :tag_values
  after_save :store_tags
  
  def self.search(query)
    where("title ILIKE ?", "%#{query}%")
  end
  
  def tag_values
    @tag_values ||= self.tags.pluck(:name).join(',')
  end
  
  private
  
    def store_tags    
      unless self.tag_values.nil?
        self.class.transaction do
          self.tags.delete_all
          self.tag_values.split(',').each do |tag_name| 
            self.tags << Tag.find_or_create_by_name(tag_name)
          end
        end
      end
    end
end
