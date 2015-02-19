class Admin::UsersController < Admin::BaseController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  	@users = User.order(:email)
  end

  def show  	
  end

  def new
  	@user = User.new
  end

  def create
  	params = user_params.dup
  	params[:password_confirmation] = params[:password]
  	@user = User.new(params)
  	if @user.save
  		flash[:notice] = "User has been created."
  		redirect_to admin_users_path
  	else
  		flash.now[:alert] = "User has not been created."
  		render action: 'new'	
  	end
  end

  def edit  	
  end

  def update
  	params = user_params.dup
  	if params[:password].blank?
  		params.delete(:password)
  		params.delete(:password_confirmation)
  	else
  		params[:password_confirmation] = params[:password]	
  	end

  	if @user.update(params)
  		flash[:notice] = "User has been updated."
  		redirect_to admin_users_path
  	else
  		flash[:alert] = "User has not been updated."
  		render action: "edit"	
  	end
  end

  def destroy
  	if @user == current_user
  		flash[:alert] = "You cannot delete yourself."
  	else
    	@user.destroy
  		flash[:notice] = "User has been deleted."			
  	end
  	redirect_to admin_users_path
  end

  private

  	def user_params
  		params.require(:user).permit(:name, 
													  			:email, 
													  			:password, 
													  			:password_confirmation, 
													  			:admin)
  	end

  	def set_user
  		@user = User.find(params[:id])
  	end
end
