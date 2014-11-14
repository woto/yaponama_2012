ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)
OffsitePayments.mode = Rails.application.config_for('application/active_merchant')['integration_mode']
