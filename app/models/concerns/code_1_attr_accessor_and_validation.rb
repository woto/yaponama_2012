# encoding: utf-8
#
module Code_1AttrAccessorAndValidation
  extend ActiveSupport::Concern

  included do

    attr_accessor :code_1

    #validates :code_1,
    #  presence: true,
    #  inclusion: { in: eval("Rails.configuration.#{self.name.underscore}_creation_reason.keys") },
    #  allow_nil: true,
    #  on: :create

    #validates :creation_reason,
    #  :presence => :true,
    #  :inclusion => { in: eval("Rails.configuration.#{self.name.underscore}_creation_reason.keys") }

  end

end
