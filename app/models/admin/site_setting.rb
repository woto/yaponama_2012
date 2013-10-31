class Admin::SiteSetting < ActiveRecord::Base
  include ConfigHelper

  validates :sms_notify_method, :inclusion => { :in => Rails.configuration.sms_notify_methods }
  validates :robokassa_integration_mode, :inclusion => { :in => Rails.configuration.robokassa_integration_modes }
  validates :default_somebody_order_rule, :inclusion => { :in => Rails.configuration.somebody_order_rules }
  validates :environment, :presence => true
  validates :emex_income_rate, :numericality => true
  validates :avtorif_income_rate, :numericality => true
  validates :retail_rate, :numericality => true
  validates :price_request_cache_with_replacements_in_seconds, :numericality => { :only_integer => true }
  validates :price_request_cache_without_replacements_in_seconds, :numericality => { :only_integer => true }
  validates :robokassa_pass_1, :presence => true
  validates :robokassa_pass_2, :presence => true
  validates :robokassa_user, :presence => true
  validates :default_somebody_prepayment, :numericality => true
  validates :default_somebody_discount, :numericality => true
  validates :avisosms_username, :presence => true
  validates :avisosms_password, :presence => true
  validates :avisosms_source_address, :presence => true
  validates :avisosms_delivery_report, :presence => true
  validates :avisosms_flash_message, :presence => true
  validates :avisosms_validity_period, :presence => true
  validates :site_address, :presence => true
  validates :site_port, :presence => true
  validates :redis_address, :presence => true
  validates :redis_port, :presence => true
  validates :socket_io_address, :presence => true
  validates :socket_io_port, :presence => true
  validates :price_address, :presence => true
  validates :price_port, :presence => true
  validates :juggernaut_address, :presence => true
  validates :juggernaut_port, :presence => true
end
