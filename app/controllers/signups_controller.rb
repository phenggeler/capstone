class SignupsController < ApplicationController
    
    before_action :set_signup, only: [:show, :edit, :update, :destroy]


  # GET /signups
  # GET /signups.json
  def index
    @signups = Signup.all
  end

  # GET /signups/1
  # GET /signups/1.json
  def show
  end

  # GET /signups/new
  def new
    @signup = Signup.new
  end

  # GET /signups/1/edit
  def edit
  end

  # POST /signups
  # POST /signups.json
  def create
    @signup = Signup.new(signup_params)
    respond_to do |format|
      if @signup.save
        #SendEmailJob.set(wait: 20.seconds).perform_later(@signup)
        Author.create(username: @signup.username, email: @signup.email, password: @signup.password, password_confirmation: @signup.password_confirmation, verified: false)
        UserMailer.new_user_email(@signup).deliver
        flash[:success] = "Your request is being process. You will be contacted once an account has been created for you. We will be in touch`"
        format.html { redirect_to pending_signups_path }
      else
        format.html { render :new }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /signups/1
  # PATCH/PUT /signups/1.json
  def update
    respond_to do |format|
      if @signup.update(signup_params)
        format.html { redirect_to @signup, notice: 'signup was successfully updated.' }
        format.json { render :show, status: :ok, location: @signup }
      else
        format.html { render :edit }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /signups/1
  # DELETE /signups/1.json
  def destroy
    @signup.destroy
    respond_to do |format|
      format.html { redirect_to signups_url, notice: 'signup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signup
      @signup = Signup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def signup_params
      params.require(:signup).permit(:username, :email, :password, :password_confirmation)
    end
end

