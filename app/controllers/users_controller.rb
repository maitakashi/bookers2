class UsersController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}

def ensure_current_user
  @user = User.find(params[:id])
  if current_user.id != @user.id
    flash[:notice]="権限がありません"
    redirect_to user_path(current_user)
  end
end

  def top
  end

  def index
    @users =User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @Book_new = Book.new
    @books =Book.where(user_id: @user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @users = User.all
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
    private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

end
