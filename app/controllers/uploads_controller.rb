class UploadsController < ApplicationController
  # TODO убрать hide_toolbar, т.к. стал использовать lightwaight layout
  #
  before_filter {@hide_toolbar = true}
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html { render layout: "lightweight" }
      format.json { render json: { files: @uploads.map{|upload| upload.to_jq_upload } } }
    end
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)
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

  def crop
    @upload = Upload.find params[:id]
    @upload.operation = 'crop'
    render layout: 'lightweight'
  end

  def rotate
    @upload = Upload.find params[:id]
    @upload.operation = 'rotate'
    render layout: 'lightweight'
  end

  def update
    @upload = Upload.find(params[:id])
    if @upload.update_attributes(upload_params)
      render 'close_and_update_image'
    end
  end

  private
  
  def upload_params
    params.require(:upload).permit!
  end

end
