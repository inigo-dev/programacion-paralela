class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :post
  
  validates :user_id, :post_id, :text, presence: true
  
  before_save :parse_text
  
  private
  
    def parse_text
      renderer = Redcarpet::Render::HTML.new(filter_html: true)
      redcarpet = Redcarpet::Markdown.new(renderer)
      self.parsed_text = redcarpet.render self.text
    end
end
