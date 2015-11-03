class Admin::Guess::CarsController < ApplicationController
  include Admin::Admined
  skip_before_action :find_resource

  def create
    respond_to do |format|
      if @resource.call
        format.html { render action: 'new' }
        format.json { render :show, status: :created, location: url }
      else
        format.html { render action: 'new' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  private


  def set_resource_class
    @resource_class = Admin::Guess::CarForm
  end

end
