ActionView::Base.send(:include, OffsitePayments::ActionViewHelper)
OffsitePayments.mode = Rails.configuration.active_merchant['integration_mode']
