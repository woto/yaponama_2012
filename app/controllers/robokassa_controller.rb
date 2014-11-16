class RobokassaController < ApplicationController
  include OffsitePayments::Integrations
  include ActionView::Helpers::NumberHelper
  skip_before_action :verify_authenticity_token
  skip_before_action :find_resource

  def success
    notify = Robokassa.notification request.raw_post, :secret => Rails.application.config_for('application/active_merchant')['pass1']
    raise RobokassaError.new("Verification failed: #{params}") unless notify.acknowledge
    redirect_to user_path, attention: "Успешно произведена оплата на сумму #{number_to_currency(notify.amount)}"
  end

  def fail
    redirect_to user_path, attention: "Оплата не была произведена"
  end

  def result
    notify = Robokassa.notification request.raw_post, :secret => Rails.application.config_for('application/active_merchant')['pass2']
    raise RobokassaError.new("Verification failed: #{params}") unless Robokassa::Notification.recognizes?(params) and notify.complete? and notify.acknowledge
    raise RobokassaError.new("Payment didn't found: #{params}") unless @payment = Payment.find_by(id: notify.item_id)
    raise RobokassaError.new("Cash mismatch") unless @payment.amount == notify.amount.to_i
    @cash = Cash.new(debit: notify.amount, somebody: @payment.somebody)
    raise RobokassaError.new("Cash didn't saved") unless @cash.save
    render :text => notify.success_response
    SellerNotifierMailer.payment(@payment).deliver_later
  end

end
