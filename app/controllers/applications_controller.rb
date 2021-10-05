class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show edit update destroy ]

  # GET /applications or /applications.json
  def index
    @withdraw = false
    if check_permissions?(session[:user_type], "withdraw_application")
      @withdraw = true
    end
    @accept = false
    if check_permissions?(session[:user_type], "accept_application")
      @accept = true
    end

    if current_user.user_type == "applicant"
      @applications = nil
      applicant = Applicant.find_by_user_id(current_user.id)
      if applicant
        @applications = Application.where(applicant_id: applicant.id)
      end
    else
      @applications = Application.all
    end
  end

  # GET /applications/1 or /applications/1.json
  def show
  end

  def accept_application
    @application = Application.find_by_id(params[:id])
    if @application.status == "withdrawn"
      return respond_to do |format|
        format.html { redirect_to @application, notice: "Cannot accept as application withdrawn." }
      end
    end
    @property = Property.find_by_id(@application.property_id)
    if @property.units == 0
      return respond_to do |format|
        format.html { redirect_to @application, notice: "Cannot accept as property is full." }
      end
    end
    @property.update(applicant_id: @application.applicant_id)
    @application.update(status: "accepted")
    @property.update(units: (@property.units - 1))
    if @property.units <= 0
      new_waitlisted_applicants = Application.where(status: "initiated", property_id: @property.id)
      new_waitlisted_applicants.update_all(status: "waitlisted")
    end
    @occupant = Occupant.new(applicant_id: @application.applicant_id, property_id: @application.property_id)

    respond_to do |format|
      if @occupant.save
        format.html { redirect_to @application, notice: "Application was accepted." }
      end
    end
  end

  def reject_application
    @application = Application.find_by_id(params[:id])
    respond_to do |format|
      if @application.status == "accepted"
        format.html { redirect_to @application, notice: "It is already accepted" }
      else
        @application.update(status: "rejected")
        format.html { redirect_to @application, notice: "Rejected successfully" }
      end
    end
  end

  def withdraw_application
    # if !check_permissions?(session[:user_type], "checkout_applicant")
    #   return redirect_to root_path
    # end
    @application = Application.find_by_id(params[:id])
    respond_to do |format|
      if @application.status != "accepted"
        @application.update(status: "withdrawn")
        format.html { redirect_to @application, notice: "Application successfully withdrawn" }
      else
        format.html { redirect_to @application, notice: "Cannot withdraw" }
      end
    end
  end

  # GET /applications/new
  def new
    @application = Application.new
    session[:property_id] = nil
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications or /applications.json
  def create
    property_id = nil
    if session[:user_type] == "admin"
      property_id = params[:application][:property_id]
    else
      property_id = params[:data][:property]
    end
    @user = nil
    if session[:user_type] == "admin"
      @user = User.find_by_id(Applicant.find_by_id(params[:application][:applicant_id]).user_id)
    else
      @user = User.find_by_id(session[:user_id])
    end

    applicant = Applicant.find_by_user_id(@user.id)

    property = Property.find_by_id(property_id)
    status = "initiated"
    if property.units <= 0
      status = "waitlisted"
    end
    applicationParams = {:status => status, :property_id => property_id, :applicant_id => applicant.id}
    @application = Application.new(applicationParams)
    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: "Application was successfully created." }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1 or /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: "Application was successfully updated." }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1 or /applications/1.json
  def destroy
    if !@application.user_id != session[:user_id]
      respond_to do |format|
        format.html { redirect_to applications_url, notice: "Not your application. what's up man?" }
        format.json { head :no_content }
      end
    end
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: "Application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(:application_id, :status)
    end
end
