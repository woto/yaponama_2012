class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :postal_address, index: true
      t.references :company, index: true
      t.decimal :delivery_cost, :precision => 8, :scale => 2, default: 0
      t.string  :status, default: 'open'
      t.references :delivery, index: true
      t.references :profile, index: true
      t.string :token, index: true
      t.string :track_number: string
      # TODO Добавить валидацию. Если способ доставки подразумевает
      # наличие track_number после отправки, то при закрытии заказа
      # наличие track_number является необходимым условием, а так же 
      # на странице пользователя в процессе всей жизни заказа необходимо
      # наличие и пояснение с ссылками на разные сайты
      t.timestamps
    end
  end
end
