class Opts::AccumulatorsController < ApplicationController
  before_action :set_accumulator, only: [:show, :edit, :update, :destroy]

  # GET /opts/accumulators
  # GET /opts/accumulators.json
  def index
    respond_to do |format|
      format.html do
        @q = @resource_class.search(params[:q])
        @accumulators = @q.result(distinct: true).page(params[:page]).per(5)
      end
      format.js do
        redirect_via_turbolinks_to request.fullpath
      end
    end
  end

  # GET /opts/accumulators/1
  # GET /opts/accumulators/1.json
  def show
  end

  # GET /opts/accumulators/new
  def new
    @accumulator = Opts::Accumulator.new
  end

  # GET /opts/accumulators/1/edit
  def edit
  end

  # POST /opts/accumulators
  # POST /opts/accumulators.json
  def create
    @accumulator = Opts::Accumulator.new(accumulator_params)

    respond_to do |format|
      if @accumulator.save
        format.html { redirect_to @accumulator, notice: 'Accumulator was successfully created.' }
        format.json { render :show, status: :created, location: @accumulator }
      else
        format.html { render :new }
        format.json { render json: @accumulator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opts/accumulators/1
  # PATCH/PUT /opts/accumulators/1.json
  def update
    respond_to do |format|
      if @accumulator.update(accumulator_params)
        format.html { redirect_to @accumulator, notice: 'Accumulator was successfully updated.' }
        format.json { render :show, status: :ok, location: @accumulator }
      else
        format.html { render :edit }
        format.json { render json: @accumulator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opts/accumulators/1
  # DELETE /opts/accumulators/1.json
  def destroy
    @accumulator.destroy
    respond_to do |format|
      format.html { redirect_to accumulators_url, notice: 'Accumulator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_resource_class
      @resource_class = Opts::Accumulator
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_accumulator
      @accumulator = Opts::Accumulator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accumulator_params
      params.require(:accumulator).permit(:voltage, :battery_capacity, :cold_cranking_amps, :length, :width, :height, :base_hold_down, :layout, :terminal_types, :case_size, :weight_filled, :spare_info_id)
    end
end
