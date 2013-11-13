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
  
  before_save :parse_content
  before_create :assign_status
  after_save :store_tags
  
  STATUS = {
    :new => 0,
    :approved => 1,
    :unapproved => 2
  }
  
  scope :approved, -> { where(status: STATUS[:approved]) }
  scope :latest, -> { order('created_at DESC') }
  
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
  
  def approve!
    self.update_attribute(:status, STATUS[:approved])
  end
  
  def reject!
    self.update_attribute(:status, STATUS[:unapproved])
  end
  
  private
    def assign_status
      self.status = STATUS[:new]
    end

    def parse_content
#      renderer = Redcarpet::Render::HTML.new(filter_html: true)
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

