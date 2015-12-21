class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
         
  enum role: [:standard, :premium, :admin]
  
  after_initialize :set_default_role, :if => :new_record?
  
  def set_default_role
    self.role ||= :standard
  end
  
  def standard?
    role == "standard"
  end
  
  def premium?
    role == "premium"
  end
  
  def admin?
    role == "admin"
  end
  
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
   
end
