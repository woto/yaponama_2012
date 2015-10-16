class UserForm < User
  include ActiveModel
  include ActiveModel::Validations

  validates :name, :phone, :email, presence: true
end
