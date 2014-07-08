# encoding: utf-8
#
module HiddenRecreate
  extend ActiveSupport::Concern

  included do
    attr_accessor :hidden_recreate
  end
end
