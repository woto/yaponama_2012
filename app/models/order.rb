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
      # Три случайных числа
      # -
      # День
      # -
      # Месяц
      # Последнее число года
      #
      # 000-00-000

      random_token = ''
      random_token += 3.times.map{ [*'0'..'9'].sample }.join
      random_token += '-'
      random_token += Time.now.utc.strftime("%d-%m-%y")
      random_token = random_token[0..8]+random_token[10]
      #random_token += 3.times.map { [*'0'..'9', *'А'..'Я'].sample }.join
      break random_token unless Order.where(token: random_token).exists?
      #random_token = SecureRandom.urlsafe_base64
      #break random_token unless Order.where(token: random_token).exists?
    end
  end
end
