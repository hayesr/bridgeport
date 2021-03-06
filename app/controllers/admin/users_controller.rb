class Admin::UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_root_nav  
  layout 'admin'
  
  def index
    @users = User.all
    
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to admin_users_path, :notice => 'User created.'
    else
      render action: 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => 'User updated'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
  
end