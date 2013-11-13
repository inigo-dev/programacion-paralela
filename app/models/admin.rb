class Admin < ActiveRecord::Base

  validates :name, :surname, :email, :encrypted_password, presence: true
  validates :password, confirmation: true, length: { minimum: 6 }, if: :needs_password?
  
  SALT = 'pr0gr4m4c10n.P4r4l3l4'  

  # True if admin needs to assign a password
  def needs_password?
    self.new_record? || !self.password.blank?
  end

  # Returns a admin with corresponding email and password or nil
  def self.authenticate(email, pwd)
    admin = self.where(:email => email).first
    if admin
      admin = nil unless admin.encrypted_password.eql? self.encrypt(pwd, SALT)
    end
    admin
  end
  
  # Returns the full_name of the admin
  def full_name
    "#{self.name} #{self.surname}"
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    self.encrypted_password = self.class.encrypt(pwd,SALT) unless pwd.blank?
  end 
  
  def change_password(current_password, new_password)
    if self.class.encrypt(current_password, SALT).eql? self.encrypted_password
      self.password = new_password
      self.save
    else
      errors.add(:current_password, "no coincide con el password actual")
      false
    end
  end
  
  protected 
  
    def self.encrypt(*args)      
      Digest::SHA1.hexdigest(args.join)
    end
end
