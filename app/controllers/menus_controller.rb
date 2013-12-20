class MenusController < ApplicationController
  before_action :log_in_required, only: [:new, :create, :edit, :update, :destroy]
  
  def new
    @menu = Menu.new
  end
  def create 
    #@menu = current_user.menus.build(menu_params)
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to :back
    else
      redirect_to root_url
    end
  end
  def show
    @menu = Menu.find(:all)
  end
  def edit
    @menu = Menu.find(params[:id])
  end
  
  def update
    @menu = Menu.find(params[:id])
    if @menu.update_attributes(menu_params)
      redirect_to @menu
    else
      render "edit"
    end
  end
  def destroy
   Menu.find(params[:id]).destroy
   redirect_to :back  
  end
  
  private
  def menu_params
    params.require(:menu).permit(:id, :item_name, :price)
  end 
  
  def log_in_required
    if current_user
      if current_user.phone != '9800000000' and current_user.role != 'admin'
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end
end
