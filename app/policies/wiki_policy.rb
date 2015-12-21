class WikiPolicy < ApplicationPolicy

    attr_reader :user, :wiki
    
    def initialize(user, wiki)
        @user = user
        @wiki = wiki
    end
    
    def new?
      user.standard?
    end
    
    def show?
      user.standard?
    end
    
    def update?
      user.standard? 
    end
    
    def create?
      user.standard? 
    end
    
    def destroy?
      user.admin? || @user == @wiki
      
    end
end