# encoding: utf-8
#
class ModificationsController < ApplicationController

  respond_to :json

  skip_before_filter :only_authenticated, :only => :search
  skip_before_action :find_resource, :only => :search

  def search
    modification_t = Modification.arel_table

    @modifications = Modification

    if params[:name].present?
      @modifications = @modifications.where(modification_t[:name].matches("#{params[:name]}%"))
    end

    if params[:generation_id]
      @modifications = @modifications.where(:generation_id => params[:generation_id])
    end

    @modifications = @modifications.order(modification_t[:name]).page params[:page]

    respond_with @modifications
  end

  private

  def set_resource_class
    @resource_class = Brand
  end

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

end

