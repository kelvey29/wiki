module ChargesHelper
  def make_public
    user_wikis = User.wikis.where(private: true)   
    user_wikis.each do |u|
        u.update_attributes(private: false)
    end
    # Wiki.where(private: true).find_each do |wiki|
    #     wiki.update_attributes(private: false)
    # end
  end
end
