class Account < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :provider, :uid, presence: true
  
  before_destroy :validate_one_account_left
  
  scope :exclude, ->(account) { where("id <> ?", account.id) }

  def self.find_or_create_from_auth_hash(auth_hash)
    account = self.where(provider: auth_hash['provider'],uid: auth_hash['uid']).first
    if account.nil?    
      user = User.create_from_auth_hash(auth_hash)
      account = user.accounts.create_from_auth_hash(auth_hash)
    end
    account
  end
  
  def self.create_from_auth_hash(auth_hash)
    self.create(provider: auth_hash['provider'], uid: auth_hash['uid'], nickname: auth_hash['info']['nickname'])
  end
  
  def profile_url
    "http://#{self.provider}.com/#{self.nickname}"
  end
  
  def siblings
    @siblings ||= self.class.where(user_id: self.user_id).exclude(self)
  end
  
  protected
    def validate_one_account_left 
      self.siblings.count(:id) > 0
    end
end
