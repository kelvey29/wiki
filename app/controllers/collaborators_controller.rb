class CollaboratorsController < ApplicationController
   
   def create
    user = User.find_by(email: params[:email])
    wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.where(user: user, wiki: wiki).first

    if user.nil?
        flash[:error] = "No user exists, try again"
    elsif user && collaborator
        flash[:error] = "User and collaborator already exist"
    elsif user && Collaborator.create(wiki: wiki, user: user)
        flash[:notice] = "You are now collaborating with #{user}!"
    else
      flash[:error] = "Something went wrong, please try again"
    end
       redirect_to edit_wiki_path(wiki)
   end
   
   def destroy
     collaborator = Collaborator.find_by(wiki_id: params[:wiki_id])
    
     if collaborator.destroy
         flash[:notice] = "Collaborator removed"
     else
         flash[:error] = "Collaborator removal failed"
     end
        redirect_to wikis_path
   end
  
   
end

