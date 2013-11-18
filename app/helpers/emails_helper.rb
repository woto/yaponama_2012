# encoding: utf-8
#
module EmailsHelper
  attr_accessor :activated

  def email_type_css_class

    if self.activated
      css_class = ""
    else
      self.activated = true
      css_class = "active"
    end

  end
end
