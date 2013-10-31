class Admin::BbbsController < ApplicationController
  before_action :set_admin_bbb, only: [:show, :edit, :update, :destroy]

  # GET /admin/bbbs
  # GET /admin/bbbs.json
  def index
    @admin_bbbs = Admin::Bbb.all
  end

  # GET /admin/bbbs/1
  # GET /admin/bbbs/1.json
  def show
  end

  # GET /admin/bbbs/new
  def new
    @admin_bbb = Admin::Bbb.new
  end

  # GET /admin/bbbs/1/edit
  def edit
  end

  # POST /admin/bbbs
  # POST /admin/bbbs.json
  def create
    @admin_bbb = Admin::Bbb.new(admin_bbb_params)

    respond_to do |format|
      if @admin_bbb.save
        format.html { redirect_to @admin_bbb, notice: 'Bbb was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_bbb }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_bbb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/bbbs/1
  # PATCH/PUT /admin/bbbs/1.json
  def update
    respond_to do |format|
      if @admin_bbb.update(admin_bbb_params)
        format.html { redirect_to @admin_bbb, notice: 'Bbb was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_bbb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/bbbs/1
  # DELETE /admin/bbbs/1.json
  def destroy
    @admin_bbb.destroy
    respond_to do |format|
      format.html { redirect_to admin_bbbs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_bbb
      @admin_bbb = Admin::Bbb.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_bbb_params
      params.require(:admin_bbb).permit(:name, :content)
    end
end
