class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]

  # GET /properties or /properties.json
  def index
    @allowed = false
    if check_permissions?(session[:user_type], "create_property")
      @allowed = true
    end
    @properties = Property.all
  end

  # GET /properties/1 or /properties/1.json
  def show
    property_feature_id = @property.attributes["property_feature_id"]
    @property_feature = PropertyFeature.find(property_feature_id)
    occupants = Occupant.where(property_id: @property.id)
    @all_applicants = nil
    if session[:user_type] == "admin"
      @all_applicants = Applicant.where.not(id: occupants.ids)
    end
    @applicants = []
    if occupants
      occupants.each do |occupant|
        @applicants.append(Applicant.find_by_id(occupant.applicant_id))
      end
    end
  end

  # GET /properties/new
  def new
    if !check_permissions?(session[:user_type], "create_property")
      redirect_to root_path
    end

    @property = Property.new
    if !session[:user_type]
      redirect_to root_path
    end
  end

  def checkout
    if !check_permissions?(session[:user_type], "checkout_applicant")
      redirect_to root_path
    end
    @property = Property.find_by_id(params[:id])
    Occupant.where(applicant_id:params[:data][:applicant_id],property_id:params[:id])[0].destroy
    @property.update(applicant_id:nil)
    @property.update(units: (@property.units + 1))
    waitlist_applicants = Application.where(status: "waitlisted", property_id:params[:id])
    waitlist_applicants.update_all(status: "initiated")
    respond_to do |format|
        format.html { redirect_to @property, notice: "Applicant got checked out successfully" }
    end
  end

  def apply
    @property = Property.find_by_id(params[:id])
    occupants = Occupant.where(property_id: @property.id)
    @application = Application.new
    @all_applicants = nil
    filtered_list = []
    if occupants
      occupants.each do |occupant|
        filtered_list.append(occupant.applicant_id)
      end
    end
    if session[:user_type] == "admin"
      @all_applicants = Applicant.where.not(id: filtered_list)
    end
    if current_user.user_type == "admin"
      respond_to do |format|
        format.html { render :apply }
      end
      #format.json { render :show, status: :created, location: @property }
    end
  end

  # GET /properties/1/edit
  def edit
    if !check_permissions?(session[:user_type], "edit_property")
      redirect_to root_path
    end
    property_feature_id = @property.attributes["property_feature_id"]
    @property_feature = PropertyFeature.find(property_feature_id)
  end

  def add_property_feature(property)
    if !check_permissions?(session[:user_type], "checkin_applicant")
      redirect_to root_path
    end
    are_pets_allowed = params[:property][:are_pets_allowed]
    in_unit_laundry = params[:property][:in_unit_laundry]
    parking = params[:property][:parking]
    feature = PropertyFeature.find_by(are_pets_allowed: are_pets_allowed, in_unit_laundry: in_unit_laundry, parking: parking) #A Bug here
    if not feature
      new_feature_hash = {:are_pets_allowed => are_pets_allowed, :in_unit_laundry => in_unit_laundry, :parking => parking}
      feature = PropertyFeature.new(new_feature_hash)
      feature.save
    end
    property.update(property_feature_id: feature.id)
  end
  
  # POST /properties or /properties.json
  def create
    if !check_permissions?(session[:user_type], "create_property")
      redirect_to root_path
    end
    @property = Property.new(property_params)
    respond_to do |format|
      if @property.save
        # , :, :in_unit_laundry, :parking
        add_property_feature(@property)
        format.html { redirect_to @property, notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    if !check_permissions?(session[:user_type], "edit_property")
      redirect_to root_path
    end
    puts "The params in update are",params
    respond_to do |format|
      if @property.update(property_params)
        add_property_feature(@property)
        format.html { redirect_to @property, notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    if !check_permissions?(session[:user_type], "checkin_applicant")
      redirect_to root_path
    end
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:name, :address, :size, :units, :terms_available, :earliest_start_date, :application_fee, :monthly_rent)
    end
end
