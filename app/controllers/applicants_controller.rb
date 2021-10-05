class ApplicantsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_applicant, only: %i[ show edit update destroy ]


  # GET /applicants or /applicants.json
  def index
    if !check_permissions?(session[:user_type], "view_applicants")
      redirect_to root_path
    end
    @applicants = Applicant.all
  end

  # GET /applicants/1 or /applicants/1.json
  def show
  end

  # GET /applicants/new
  def new
    @applicant = Applicant.new
  end

  # GET /applicants/1/edit
  def edit
    if !check_permissions?(session[:user_type], "edit_applicant")
      redirect_to root_path
    end
  end

  # POST /applicants or /applicants.json
  def create
    email = params[:applicant][:email]
    userHash = {:email => email, :user_type => "applicant"}
    @applicant = nil
    #
    @user = User.new(userHash)
    respond_to do |format|
      if @user.save
        @applicant = Applicant.new(applicant_params)
        @applicant.user_id = @user.id
        if @applicant.save
          if(not current_user.nil? and current_user.user_type == "admin")
            format.html { redirect_to @applicant, notice: "Applicant was successfully created by Admin." }
            format.json { render :show, status: :created, location: @applicant }
          else
            format.html { redirect_to login_path, notice: "Applicant was successfully created." }
            format.json { render :show, status: :created, location: @applicant }
          end
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @applicant.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /applicants/1 or /applicants/1.json
  def update
    if !check_permissions?(session[:user_type], "edit_applicant")
      redirect_to root_path
    end
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: "Applicant was successfully updated." }
        format.json { render :show, status: :ok, location: @applicant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1 or /applicants/1.json
  def destroy
    if !check_permissions?(session[:user_type], "delete_applicant")
      redirect_to root_path
    end
    @applicant.destroy
    respond_to do |format|
      format.html { redirect_to applicants_url, notice: "Applicant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def applicant_params
      params.require(:applicant).permit(:applicant_id, :name, :password, :email, :phone_number)
    end
end
