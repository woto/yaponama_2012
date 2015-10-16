class Orders::AbstractForm

  include ActiveModel
  include ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Dirty

  attr_accessor :user_form
  attr_accessor :notes
  attr_accessor :order

  validates :user_form, associated: true

  def user_form_attributes=(params={})
    self.user_form = UserForm.find(params[:id]).tap do |user_form|
      user_form.assign_attributes(params)
    end
  end

  def initialize(params={})
    self.user_form_attributes = params[:user_form_attributes]
  end

  def to_label
    order.to_label
  end

  def persisted?
    false
  end

  def call
    if valid?
      true
    end
  end

end
