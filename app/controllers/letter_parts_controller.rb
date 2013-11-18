# encoding: utf-8
#
class LetterPartsController < ApplicationController
  before_action :set_letter_part, only: [:show, :edit, :update, :destroy]

  ## GET /letter_parts
  ## GET /letter_parts.json
  #def index
  #  @letter_parts = LetterPart.all
  #end

  ## GET /letter_parts/1
  ## GET /letter_parts/1.json
  #def show
  #end

  def cid
    letter_part = LetterPart.where(cid: params[:cid]).first
    send_data letter_part.body, filename: letter_part.filename, type: letter_part.letter_part_type
  end

  ## GET /letter_parts/new
  #def new
  #  @letter_part = LetterPart.new
  #end

  ## POST /letter_parts
  ## POST /letter_parts.json
  #def create
  #  @letter_part = LetterPart.new(letter_part_params)

  #  respond_to do |format|
  #    if @letter_part.save
  #      format.html { redirect_to @letter_part, notice: 'Letter part was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @letter_part }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @letter_part.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  ## PATCH/PUT /letter_parts/1
  ## PATCH/PUT /letter_parts/1.json
  #def update
  #  respond_to do |format|
  #    if @letter_part.update(letter_part_params)
  #      format.html { redirect_to @letter_part, notice: 'Letter part was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @letter_part.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  ## DELETE /letter_parts/1
  ## DELETE /letter_parts/1.json
  #def destroy
  #  @letter_part.destroy
  #  respond_to do |format|
  #    format.html { redirect_to letter_parts_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter_part
      @letter_part = LetterPart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def letter_part_params
      params.require(:letter_part).permit(:letter_id, :cid, :type, :is_attachment, :filename, :charset, :body, :size)
    end
end
