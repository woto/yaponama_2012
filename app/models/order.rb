class Order < ActiveRecord::Base
  include BelongsToUser
  include BelongsToCreator

  belongs_to :deliveries_place, class_name: 'Deliveries::Place'
  belongs_to :delivery_variant, class_name: 'Deliveries::Variant'
  belongs_to :postal_address

  has_many :products, :dependent => :destroy

  before_create :generate_token

  def to_param
    token
  end

  def to_label
    token
  end

  def self.finder token
    find_by_token token
  end

  private

  def generate_token
    self.token = loop do
      # 000-дд-мм-гг
      random_token = ''
      random_token += 3.times.map{ [*'0'..'9'].sample }.join
      random_token += '-'
      random_token += Time.now.utc.strftime("%d-%m-%y")
      break random_token unless Order.where(token: random_token).exists?
    end
  end
end
