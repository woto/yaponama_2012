# encoding: utf-8
#
class Admin::CashesController < CashesController
  include Admin::Admined
  
  def create
    respond_to do |format|
      if @resource.save
        format.html { redirect_to [:admin, @user], success: "Успешно внесено #{view_context.number_to_currency(@resource.debit)}" }
      else
        format.html { render action: "new" }
      end
    end

  end

end
