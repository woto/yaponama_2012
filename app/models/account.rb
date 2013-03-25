class Account < ActiveRecord::Base
  belongs_to :accountable, :polymorphic => true, touch: true
  has_many :money_transactions

  # TODO Хотелось бы это переделать в виртуальные методы (вопрос с dirty)
  validates :credit, :numericality => true
  validates :debit, :numericality => true

  def to_label
    accountable.to_label
  end

  # TODO FIXME WARNING при создании юзера (и по-видимому поставщика) не фиксируется начальные значения!!!
  # ps Это было еще до того как я отказался от прямого изменения account и переделал через ....money_transactions.create...

end
