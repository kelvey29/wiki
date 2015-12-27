class Wiki < ActiveRecord::Base
  belongs_to :user
  
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  
  # def self.visible_to(user)
  #   # return if user.nil?
  #   # wikis = Wiki.where(private: false)

  #   # if user.premium?
  #   #   wikis << user.wikis.where(private: true)
  #   # end
  #   wikis 
  # end
  
  def self.visible_to(user)
    wikis = Wiki.all
    case
      when user.standard?
        wikis 
      when user.premium? || user.admin?
        wikis + user.wikis.where(private: true) 
    end  
  end
end
