class WikisController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
 
  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
  def create
    @wiki = Wiki.new(wiki_params)
    authorize @wiki
    
    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error creating the Wiki. Please try again."
      render :new
    end
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    
    
    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki was updated"
      redirect_to @wiki
    else
      flash[:error] = "Error saving Wiki. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the Wiki."
      render :show
    end
  end
  
  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :user_id)
  end
end
