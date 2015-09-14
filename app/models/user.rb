class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Concerns::Models::Bot
  include Concerns::Models::Authentication
  include Concerns::Models::Authorization
  include BelongsToCreator

  with_options dependent: :destroy do
    has_many :cars
    has_many :products
    has_many :postal_addresses
    has_many :orders
  end

  def to_label
    [name, phone, email].reject{|value| value.blank?}.join(', ')
  end

end
