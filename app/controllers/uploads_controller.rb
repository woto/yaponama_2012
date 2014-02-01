# encoding: utf-8
#
class UploadsController < ApplicationController
  # TODO убрать hide_toolbar, т.к. стал использовать lightwaight layout
  #
  before_filter {@hide_toolbar = true}
  # GET /uploads
  # GET /uploads.json
  def index
    @resources = Upload.all

    respond_to do |format|
      format.html { render layout: "lightweight" }
      format.json { render json: { files: @resources.map{|upload| upload.to_jq_upload } } }
    end
  end

  # POST /uploads
  # POST /uploads.json
  def create
    #@resource = Upload.new(upload_params)
    #@resource.user = current_user

    respond_to do |format|
      if @resource.save
        format.html {
          render :json => { files: [@resource.to_jq_upload] },
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: { files: [@resource.to_jq_upload] }, status: :created, location: @resource }
      else
        format.html { render action: "new" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def crop
    @resource = Upload.find params[:id]
    @resource.operation = 'crop'
    render layout: 'lightweight'
  end

  def rotate
    @resource = Upload.find params[:id]
    @resource.operation = 'rotate'
    render layout: 'lightweight'
  end

  def update
    @resource = Upload.find(params[:id])
    if @resource.update_attributes(upload_params)
      render 'close_and_update_image'
    end
  end

  private
  
  def upload_params
    params.require(:upload).permit!
  end

  def set_resource_class
    @resource_class = Upload
  end

end
