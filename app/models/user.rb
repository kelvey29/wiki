class User < ActiveRecord::Base
  # has_many :wikis, dependent: :destroy
  has_many :collaborators
  has_many :wikis, through: :collaborators
         
  enum role: [:standard, :premium, :admin]
  
  after_initialize :set_default_role, :if => :new_record?
  
  def set_default_role
    self.role ||= :standard
  end
  
  def can_update?(resource)
    self.admin? || resource.user == self
  end
  
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
   
end
