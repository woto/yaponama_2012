class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :postal_address, index: true
      t.references :company, index: true
      t.decimal :delivery_cost, :precision => 8, :scale => 2, default: 0
      t.string  :status, default: 'open'
      t.references :delivery_place, index: true
      t.references :delivery_variant, index: true
      t.references :delivery_option, index: true

      # Получатель
      t.references :profile, index: true
      t.text :cached_profile

      t.boolean :full_prepayment_required
      t.boolean 'legal'
      t.boolean 'phantom', default: true
      t.string :token, index: true
      t.string :track_number
      # TODO Добавить валидацию. Если способ доставки подразумевает
      # наличие track_number после отправки, то при закрытии заказа
      # наличие track_number является необходимым условием, а так же 
      # на странице пользователя в процессе всей жизни заказа необходимо
      # наличие и пояснение с ссылками на разные сайты
      t.timestamps
    end
  end
end
