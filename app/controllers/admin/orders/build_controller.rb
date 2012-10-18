class Admin::Orders::BuildController < Admin::ApplicationController
  include Wicked::Wizard

  steps :name, :postal_address, :delivery_cost

  def show
    case :step
    when :name
    when :postal_address
    when :delivery_cost
    end

    render_wizard
  end

  def update
  end

  def create
    debugger
    @order = Order.create
    redirect_to wizard_path(steps.first, :order_id => @order.id)
  end
end
