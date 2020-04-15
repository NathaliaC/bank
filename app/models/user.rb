class User < ApplicationRecord
  include BCrypt
  
  has_many :bank_accounts, dependent: :destroy
  
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 6..20 }
  validates :name, presence: true
  validates :user_number, presence:true, uniqueness: true

  before_validation :load_defaults

  def load_defaults
    if self.new_record?
      self.user_number = SecureRandom.uuid
    end
  end
end