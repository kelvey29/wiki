module ChargesHelper
  def make_public
    personal_wikis = current_user.wikis
    personal_wikis.where(private: true).find_each do |wiki|
        wiki.update_attributes(private: false)
    end
  end
end
