require 'pygmentize_html' 

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comments
  has_many :code_blocks
  
  attr_accessor :tag_values
  
  validates :title, :content, :user_id, presence: true
  validates :views, numericality: { only_integer: true }
  
  accepts_nested_attributes_for :code_blocks, allow_destroy: true
  
  before_save :parse_content
  before_create :assign_status
  after_save :store_tags
  validates_associated :code_blocks
  
  STATUS = {
    :new => 0,
    :approved => 1,
    :unapproved => 2
  }
  
  STATUS_TEXT = {
    STATUS[:new] => "Nuevo",
    STATUS[:approved] => "Aprobado",
    STATUS[:unapproved] => "Rechazado"
  }
  
  scope :new_posts, -> { where(status: STATUS[:new]) }
  scope :approved, -> { where(status: STATUS[:approved]) }
  scope :latest, -> { order('created_at DESC') }
  scope :search_by_status, ->(status) { where(status: status ) }
  scope :search_by_tag_id, ->(tag_id) { joins(post_tags: :tag).where(tags: { id: tag_id } ) }
  
  def self.search(query)
    self.uniq.joins(post_tags: :tag).where("posts.title ILIKE :query OR posts.content ILIKE :query OR tags.name ILIKE :query", query: "%#{query}%")
  end
  
  def tag_values
    @tag_values ||= self.tags.pluck(:name).join(',')
  end
  
  def new?
    self.status.eql? STATUS[:new]
  end
  
  def approved?
    self.status.eql? STATUS[:approved]    
  end
  
  def unapproved?
    self.status.eql? STATUS[:unapproved]
  end
  
  def self.approve!
    self.update_all(status: STATUS[:approved])
  end
  
  def self.reject!
    self.update_all(status: STATUS[:unapproved])
  end
  
  def approve!
    self.update_attribute(:status, STATUS[:approved])
  end
  
  def reject!
    self.update_attribute(:status, STATUS[:unapproved])
  end
  
  def view!
    self.increment!(:views)
  end
  
  def related_references
    tag_ids = self.tags.pluck(:id)
    references = Reference.includes(:reference_type)
                          .joins(:reference_tags)
                          .where("reference_tags.tag_id IN (?)", tag_ids)
    grouped_hash = {}
    references.each do |reference|
      grouped_hash[reference.reference_type_id] ||= []
      grouped_hash[reference.reference_type_id] << reference
    end
    grouped_hash
  end
  
  private
    def assign_status
      self.status = STATUS[:new]
    end

    def parse_content
      renderer = PygmentizeHTML.new(filter_html: true)      
      redcarpet = Redcarpet::Markdown.new(renderer, { fenced_code_blocks: true })
      self.parsed_content = redcarpet.render self.content
    end
    
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

