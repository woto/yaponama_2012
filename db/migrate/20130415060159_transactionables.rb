class Transactionables < ActiveRecord::Migration
  def self.up
    [:phones, :names, :email_addresses, :postal_addresses, :cars, :products, :companies, :accounts].each do |table_name|
      create_table "#{table_name.to_s.singularize}_transactions".to_sym do |t|

        table_model = table_name.to_s.singularize.camelize.constantize

        # id привязанного объекта
        eval "t.references :#{table_name.to_s.singularize}"

        # id пользователя, чтобы можно было получать и элементы, которые были удалены
        t.references :user
        # Ну и контроллировать кто это сделал
        t.references :creator

        # TODO позже разобраться (в Account нету notes_invisible)
        # Выделяется из общей картины, т.к. действует так же, за исключением, что не фикируется автоматически
        # а управляется вручную и плюс ко всему этому имеет дополнительное поле - id товарной транзакции
        if table_model == Account
          t.references :product_transaction
          t.text :comment
        end

        table_model.columns.each do |column|
          if column.name != "id"
            eval "t.#{column.type.to_s} :#{column.name}_before"
            eval "t.#{column.type.to_s} :#{column.name}_after"
          end
        end

        t.timestamps

      end
    end
  end
end
