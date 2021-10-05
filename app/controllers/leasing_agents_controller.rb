class LeasingAgentsController < ApplicationController
  before_action :set_leasing_agent, only: %i[ show edit update destroy ]

  # GET /leasing_agents or /leasing_agents.json
  def index
    if !check_permissions?(session[:user_type], "create_leasing_agent")
      redirect_to root_path
    end
    @leasing_agents = LeasingAgent.all
  end

  # GET /leasing_agents/1 or /leasing_agents/1.json
  def show
    if !check_permissions?(session[:user_type], "create_leasing_agent")
      redirect_to root_path
    end
  end

  # GET /leasing_agents/new
  def new
    if !check_permissions?(session[:user_type], "create_leasing_agent")
      redirect_to root_path
    end
    @leasing_agent = LeasingAgent.new
  end

  # GET /leasing_agents/1/edit
  def edit
    if !check_permissions?(session[:user_type], "create_leasing_agent")
      redirect_to root_path
    end
  end

  # POST /leasing_agents or /leasing_agents.json
  def create
    # uncomment these once you add admin
    if !check_permissions?(session[:user_type], "create_leasing_agent")
      redirect_to root_path
    end
    email = params[:leasing_agent][:email]
    userHash = {:email => email, :user_type => "leasing_agent"}
    @applicant = nil

    @user = User.new(userHash)
    if @user.save
      @leasing_agent = LeasingAgent.new(leasing_agent_params)
      @leasing_agent.user_id = @user.id
      respond_to do |format|
        if @leasing_agent.save
          format.html { redirect_to @leasing_agent, notice: "Leasing agent was successfully created." }
          format.json { render :show, status: :created, location: @leasing_agent }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @leasing_agent.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /leasing_agents/1 or /leasing_agents/1.json
  def update
    if !check_permissions?(session[:user_type], "delete_leasing_agent")
      redirect_to root_path
    end
    respond_to do |format|
      if @leasing_agent.update(leasing_agent_params)
        format.html { redirect_to @leasing_agent, notice: "Leasing agent was successfully updated." }
        format.json { render :show, status: :ok, location: @leasing_agent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @leasing_agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leasing_agents/1 or /leasing_agents/1.json
  def destroy
    if !check_permissions?(session[:user_type], "delete_leasing_agent")
      redirect_to root_path
    end
    @leasing_agent.destroy
    respond_to do |format|
      format.html { redirect_to leasing_agents_url, notice: "Leasing agent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leasing_agent
      @leasing_agent = LeasingAgent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leasing_agent_params
      params.require(:leasing_agent).permit(:password, :name, :phone_number, :email)
    end
end
