# encoding: utf-8
#
class Admin::CashesController < CashesController
  include Admin::Admined
  
  def create
    respond_to do |format|
      if @resource.save
        format.js { redirect_to url_for(action: :show), attention: "Успешно внесено #{view_context.number_to_currency(@resource.debit)}" }
      else
        format.js { render action: "new" }
      end
    end

  end

  private

  def find_resource
    @resource = @resource_class.new
  end

end
