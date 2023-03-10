class TutorsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_tutor, only: %i[ show edit update destroy ]

  # GET /tutors or /tutors.json
  def index
    @tutors = Tutor.all
  end

  # POST /tutors/search.json
  def search

    if params[:search][:location].blank?
      @tutors = Tutor.where("subject = ? AND is_remote = true", params[:search][:subject])
    else
      @tutors = Tutor.where("subject = ? AND location = ?", params[:search][:subject], params[:search][:location]) #"subject = ? AND location = ?", params[:search][:subject], params[:search][:location]
    end
  end

  # GET /tutors/1 or /tutors/1.json
  def show
  end

  # GET /tutors/new
  def new
    @tutor = Tutor.new
  end

  # GET /tutors/1/edit
  def edit
  end

  # POST /tutors or /tutors.json
  def create
    @tutor = Tutor.new(tutor_params)

    respond_to do |format|
      if @tutor.save
        format.html { redirect_to tutor_url(@tutor), notice: "Tutor was successfully created." }
        format.json { render :show, status: :created, location: @tutor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutors/1 or /tutors/1.json
  def update
    respond_to do |format|
      if @tutor.update(tutor_params)
        format.html { redirect_to tutor_url(@tutor), notice: "Tutor was successfully updated." }
        format.json { render :show, status: :ok, location: @tutor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutors/1 or /tutors/1.json
  def destroy
    @tutor.destroy

    respond_to do |format|
      format.html { redirect_to tutors_url, notice: "Tutor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor
      @tutor = Tutor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tutor_params
      params.require(:tutor).permit(:name, :degree, :description, :email, :location, :is_remote, :phone_number, :start_date, :subject, :user_id)
    end
end
