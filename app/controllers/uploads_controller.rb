class UploadsController < ApplicationController
  before_filter {@hide_toolbar = true}
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { files: @uploads.map{|upload| upload.to_jq_upload } } }
    end
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload: upload_params[:upload][0])
    #@upload = Upload.new(upload_params)
    @upload.user = current_user

    respond_to do |format|
      if @upload.save
        format.html {
          render :json => { files: [@upload.to_jq_upload] },
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: { files: [@upload.to_jq_upload] }, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

  private
  
  def upload_params
    params.require(:upload).permit!
  end

end
