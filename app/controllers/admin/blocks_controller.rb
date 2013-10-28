class Admin::BlocksController < ApplicationController
  before_action :set_admin_block, only: [:show, :edit, :update, :destroy]

  # GET /admin/blocks
  # GET /admin/blocks.json
  def index
    @admin_blocks = Admin::Block.all
  end

  # GET /admin/blocks/1
  # GET /admin/blocks/1.json
  def show
  end

  # GET /admin/blocks/new
  def new
    @admin_block = Admin::Block.new
  end

  # GET /admin/blocks/1/edit
  def edit
  end

  # POST /admin/blocks
  # POST /admin/blocks.json
  def create
    @admin_block = Admin::Block.new(admin_block_params)

    respond_to do |format|
      if @admin_block.save
        format.html { redirect_to @admin_block, notice: 'Block was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_block }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/blocks/1
  # PATCH/PUT /admin/blocks/1.json
  def update
    respond_to do |format|
      if @admin_block.update(admin_block_params)
        format.html { redirect_to @admin_block, notice: 'Block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/blocks/1
  # DELETE /admin/blocks/1.json
  def destroy
    @admin_block.destroy
    respond_to do |format|
      format.html { redirect_to admin_blocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_block
      @admin_block = Admin::Block.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_block_params
      params.require(:admin_block).permit(:name, :content)
    end
end
