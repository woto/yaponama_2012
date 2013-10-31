class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy]

  def download
  end

  ## PATCH/PUT /letters/1
  ## PATCH/PUT /letters/1.json
  #def update
  #  respond_to do |format|
  #    if @letter.update(letter_params)
  #      format.html { redirect_to @letter, notice: 'Letter was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @letter.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  ## DELETE /letters/1
  ## DELETE /letters/1.json
  #def destroy
  #  @letter.destroy
  #  respond_to do |format|
  #    format.html { redirect_to letters_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    ## Use callbacks to share common setup or constraints between actions.
    #def set_letter
    #  @letter = Letter.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def letter_params
    #  params.require(:letter).permit(:user_id, :letter_id, :sender, :recipients, :subject, :source, :size, :type)
    #end
end
