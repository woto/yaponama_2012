class Transactionables < ActiveRecord::Migration
  def self.up
    [:phones, :names, :email_addresses, :passports, :postal_addresses, :cars, :products, :companies, :accounts, :orders, :profiles].each do |table_name|
      create_table "#{table_name.to_s.singularize}_transactions".to_sym do |t|

        table_model = table_name.to_s.singularize.camelize.constantize

        # id привязанного объекта
        eval "t.references :#{table_name.to_s.singularize}, index: true"

        # Используется для profileable. Не для ProductTransaction
        t.references :user, index: true

        # Ну и контроллировать кто это сделал
        t.references :creator, index: true

        # TODO позже разобраться (в Account нету notes_invisible)
        # Выделяется из общей картины, т.к. действует так же, за исключением, что не фикируется автоматически
        # а управляется вручную и плюс ко всему этому имеет дополнительное поле - id товарной транзакции
        if table_model == Account
          t.references :product_transaction, index: true
          t.text :comment
        end

        table_model.columns.each do |column|
          # ID Отслеживаемого объекта никогда не может меняться,
          # поэтому следить за ним не надо. В отличии от supplier_id (в противовес user_id)
          # TODO
          #if table_model == Account && ["accountable_id", "accountable_type"].include?(column.name)
          #  eval "t.#{column.type.to_s} :#{column.name}"
          #elsif !(["user_id", "id", "created_at", "updated_at"].include?(column.name))
          if column.name != "id"
            eval "t.#{column.type.to_s} :#{column.name}_before"
            eval "t.#{column.type.to_s} :#{column.name}_after"
          end
        end

        # TODO
        #t.column :created_at, :datetime
        t.timestamps

      end
    end
  end
end
