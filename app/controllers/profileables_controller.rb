# encoding: utf-8
#
class ProfileablesController < ApplicationController

  include Grid::Profileable

  skip_before_filter :set_grid, :only => [:edit, :update, :new, :create, :show, :destroy]

  def transactions
    if params[:id]
      @resource = @resource_class.find(params[:id])
      @transactions = eval "@resource.#{@resource_class.to_s.underscore}_transactions"
    else
      if @somebody
        @transactions = eval "#{@resource_class.to_s}Transaction.where('somebody_id_before = ? OR somebody_id_after = ?', #{@somebody.id}, #{@somebody.id})"
      else
        @transactions = eval "#{@resource_class.to_s}Transaction"
      end

      #if @user
      #  @transactions = eval "@user.#{@resource_class.to_s.underscore}_transactions"
      #else
      #  @transactions = eval "#{@resource_class.to_s}Transaction"
      #end
    end

    @transactions = @transactions.order(:id => :desc)
  end

end
