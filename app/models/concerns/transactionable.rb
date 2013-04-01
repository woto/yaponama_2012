module Transactionable
  extend ActiveSupport::Concern

  included do
    eval "has_many :#{self.to_s.underscore}_transactions"
    before_save :record_log
    before_destroy :destroy_log
  end

  private

  def destroy_log
    @transaction = eval("#{self.class.to_s.underscore}_transactions.build")
    @transaction.user = self.user
    @transaction.creator = User.current_user

    self.class.column_names.each do |column_name|
      eval "@transaction.#{column_name}_before = #{column_name}_was"
      eval "@transaction.#{column_name}_after = nil"
    end
    @transaction.save
  end

  def record_log
    #if changes.present?
    #  debugger
    #  # TODO
    #  # Почему-то если сохранить заказ (менял стоимость доставки заказа)
    #  # сохраняется и (уже сохраненный) product
    #  product_transaction = product_transactions.build
    #  h = {}
    #  self.changes.map{|k,v| h["log_#{k}"] = v[1]}
    #  # TODO проверить, раньше было update_attributes
    #  product_transaction.assign_attributes(h)
    #end
    if changes.present?
      @transaction = eval("#{self.class.to_s.underscore}_transactions.build")
      @transaction.user = self.user
      @transaction.creator = User.current_user

      self.class.column_names.each do |column_name|
        eval "@transaction.#{column_name}_before = #{column_name}_was"
        eval "@transaction.#{column_name}_after = #{column_name}"
      end
    end
  end
end
