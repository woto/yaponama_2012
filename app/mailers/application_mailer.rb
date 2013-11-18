# encoding: utf-8
#
class ApplicationMailer < ActionMailer::Base

  def to_avisosms_format(value)
    value.gsub(/[^0-9]/, '').insert(0, '+')
  end

end
