class Transactionables < ActiveRecord::Migration
  def self.up
    [:phones, :names, :emails, :passports, :postal_addresses, :cars, :products, :companies, :accounts, :orders, :profiles, :pages, :somebodies, :brands, :blocks, :faqs].each do |table_name|
      create_table "#{table_name.to_s.singularize}_transactions".to_sym do |t|

        table_model = table_name.to_s.singularize.camelize.constantize

        # id привязанного объекта
        eval "t.references :#{table_name.to_s.singularize}, index: true"

        # Операция create, update, destroy
        unless table_model == Account
          t.string :operation
        end

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
          # поэтому следить за ним не надо. В отличии от supplier_id (в противовес somebody_id)
          # TODO
          if table_model == Account && ["accountable_id", "accountable_type"].include?(column.name)
            #eval "t.#{column.type.to_s} :#{column.name}"
            nil
          elsif !(["creator_id", "id", "created_at", "updated_at"].include?(column.name))
            eval "t.#{column.type.to_s} :#{column.name}_before"
            eval "t.#{column.type.to_s} :#{column.name}_after"
          end
        end

        # У транзакции есть только дата создания.
        t.column :created_at, :datetime

      end
    end
  end
end
