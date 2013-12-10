class User < ActiveRecord::Base
  has_many :accounts
  has_many :posts
  has_many :subscriptions
  has_many :tags, through: :subscriptions
  validates :name, presence: true
  
  def full_name
    "#{self.name} #{self.surname}"
  end
  
  def feed_posts    
    Post.approved.joins(:post_tags).where("post_tags.tag_id IN (?)", self.subscriptions.pluck(:tag_id))
  end
  
  def follows?(tag)
    self.subscriptions.where(tag_id: tag.id).count(:id) > 0
  end
  
  def owns?(post)
    post.user_id.eql? self.id
  end
  
  def linked?(provider)
    self.accounts.where(provider: provider).count(:id) > 0
  end
  
  def add_account(auth_hash)  
    account = self.accounts.where(provider: auth_hash['provider'], uid: auth_hash['uid']).first
    if account.nil?
      account = self.accounts.create_from_auth_hash(auth_hash)
    end
    account
  end
  
  def self.create_from_auth_hash(auth_hash)
    name = auth_hash['info']['first_name'] || auth_hash['info']['name'].split(" ")[0]
    surname = auth_hash['info']['last_name'] || auth_hash['info']['name'].split(" ").drop(1).join(" ")
    profile_picture = auth_hash['info']['image'] || "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash1/211228_691516660_1206690031_q.jpg"
    self.create(
        name: name,
        surname: surname,
        email: auth_hash['info']['email'], 
        nickname: auth_hash['info']['nickname'].underscore,
        profile_picture_url: profile_picture
    )
  end
end
