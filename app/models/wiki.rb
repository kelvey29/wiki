class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  
  def self.visible_to(user)
    wikis = []
    return wikis if user.nil?
    wikis = Wiki.where(private: false)

    if user.premium?
      wikis = wikis + Wiki.where(private: true)
    end
    wikis 
  end
 
end
