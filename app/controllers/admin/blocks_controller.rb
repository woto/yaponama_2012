class Admin::BlocksController < ApplicationController
  # GET /admin/blocks
  # GET /admin/blocks.json
  def index
    @admin_blocks = Admin::Block.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_blocks }
    end
  end

  # GET /admin/blocks/1
  # GET /admin/blocks/1.json
  def show
    @admin_block = Admin::Block.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_block }
    end
  end

  # GET /admin/blocks/new
  # GET /admin/blocks/new.json
  def new
    @admin_block = Admin::Block.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_block }
    end
  end

  # GET /admin/blocks/1/edit
  def edit
    @admin_block = Admin::Block.find(params[:id])
  end

  # POST /admin/blocks
  # POST /admin/blocks.json
  def create
    @admin_block = Admin::Block.new(params[:admin_block])

    respond_to do |format|
      if @admin_block.save
        format.html { redirect_to @admin_block, notice: 'Block was successfully created.' }
        format.json { render json: @admin_block, status: :created, location: @admin_block }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/blocks/1
  # PUT /admin/blocks/1.json
  def update
    @admin_block = Admin::Block.find(params[:id])

    respond_to do |format|
      if @admin_block.update_attributes(params[:admin_block])
        format.html { redirect_to @admin_block, notice: 'Block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/blocks/1
  # DELETE /admin/blocks/1.json
  def destroy
    @admin_block = Admin::Block.find(params[:id])
    @admin_block.destroy

    respond_to do |format|
      format.html { redirect_to admin_blocks_url }
      format.json { head :no_content }
    end
  end
end
