class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def zero_users_or_authenticated
    unless User.count == 0 || current_user
      redirect_to root_path
      return false
    end
  end

  def index
    @users = User.order('verified DESC')
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if (User.count == 0 || current_user)
      @user.verified = true
    else
      @user.verified = false
      UserMailer.new_user_email(@user).deliver
    end
    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver
        UserMailer.new_user_email(@user).deliver
        flash[:notice] = "You will be contacted once your account has been approved"
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        if(@user.verified == true)
          UserMailer.approval_user_email(@user).deliver
        else
          UserMailer.suspended_user_email(@user).deliver
        end
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :verified)
    end
end
