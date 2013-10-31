class ProfileablesController < ApplicationController

  include GridProfileable

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

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

  def user_get
    @user = current_user
  end

  def somebody_get
    @somebody = current_user
  end

  def supplier_get
  end

end
