# encoding: utf-8
#
class ModificationsController < ApplicationController

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

end

