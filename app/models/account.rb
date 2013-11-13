class Account < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :provider, :uid, presence: true

  def self.find_or_create_from_auth_hash(auth_hash)
    account = self.where(provider: auth_hash['provider'],uid: auth_hash['uid']).first
    if account.nil?    
      user = User.create_from_auth_hash(auth_hash)
      account = user.accounts.create(provider: auth_hash['provider'], uid: auth_hash['uid'])
    end
    account
  end
end
