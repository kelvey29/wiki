class CollaboratorsController < ApplicationController
   
   def create
    @user = User.find_by(email: params[:email])
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.where(user: @user, wiki: @wiki).first

    if user.nil?
        flash[:error] = "No user exists, try again"
    elsif user && collaborator
        flash[:error] = "User and collaborator already exist"
    elsif user && Collaborator.create(wiki: @wiki, user: @user)
        flash[:notice] = "You are now collaborating with #{@user}!"
    else
      flash[:error] = "Something went wrong, please try again"
    end
       redirect_to edit_wiki_path(wiki)
   end
   
   def destroy
     collaborators = Collaborator.where(id: :wiki_id)
     collaborated_user = User.where(id: collaborators.pluck(:user_id))
    # @wiki = Wiki.find(params[:wiki_id])
    # @collaborator = Collaborator.find_by(id: @wiki)
    
     if collaborated_user.destroy
         flash[:notice] = "Collaborator removed"
     else
         flash[:error] = "Collaborator removal failed"
     end
        redirect_to edit_wiki_path(wiki)
   end
  
   
end

