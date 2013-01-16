require 'active_merchant'
require 'active_merchant/billing/integrations/action_view_helper'

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)
ActiveMerchant::Billing::Base.integration_mode = Admin::SiteSetting.current_environment.robokassa_integration_mode.to_sym
