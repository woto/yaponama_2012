class Account < ActiveRecord::Base
  include Selectable

  belongs_to :somebody, inverse_of: :account
  has_many :account_transactions

  # TODO Хотелось бы это переделать в виртуальные методы (вопрос с dirty)
  validates :credit, :numericality => true
  validates :debit, :numericality => true

  def to_label
    accountable.to_label
  end

  # TODO FIXME WARNING при создании юзера (и по-видимому поставщика) не фиксируется начальные значения!!!
  # ps Это было еще до того как я отказался от прямого изменения account и переделал через ....money_transactions.create...

  def credit=(val)
    raise 'Прямое изменение credit запрещено, воспользуйтесь AccountTransaction'
  end

  def debit=(val)
    raise 'Прямое изменение debit запрещено, воспользуйтесь AccountTransaction'
  end

  after_save do
    somebody.update_columns(:cached_debit => debit, :cached_credit => credit)
  end

  after_save do
    #def check_orders
    #  raise '1'
    #  # TODO CHECK
    #  
    #  if order_rule.to_sym == :none
    #    return
    #  elsif order_rule.to_sym == :all 
    #    inorder_orders = orders.where(:status => :inorder)
    #    unless (account.debit + inorder_orders.inject(0){|summ, order| summ += order.order_cost}) * prepayment / 100.00 <= account.credit
    #      return
    #    end

    #    inorder_orders.each do |order|
    #      if (account.debit + order.order_cost) * prepayment / 100.00 <= account.credit
    #        order.status = :ordered
    #        order.products.each do |product|
    #          product.update_attributes(:status => :ordered)
    #        end
    #        account.debit += order.order_cost
    #        order.save
    #        account.save
    #      end
    #    end

    #  end

    #end
  end



end
