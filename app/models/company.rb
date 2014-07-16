# encoding: utf-8
#
class Company < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToCreator
  include BelongsToSomebody
  include Transactionable
  include Selectable
  include CachedLegalAddress
  include CachedActualAddress
  include RenameMeConcernTest

  read_only :creation_reason

  #include ProfileConfirmRequired

  attr_accessor :legal_address_type, :actual_address_type
  validates :legal_address_type, :inclusion => { :in => ['new', 'old'] }, allow_nil: true #TODO Проверить потом
  validates :actual_address_type, :inclusion => { :in => ['new', 'old'] }, allow_nil: true

  belongs_to :legal_address, :class_name => 'PostalAddress', autosave: true
  validates :new_legal_address, presence: true, associated: true, if: -> { legal_address_type == 'new' }
  validates :old_legal_address, presence: true, associated: true, inclusion: { in: proc {|company| company.somebody.postal_addresses } }, if: -> { legal_address_type == 'old' }

  belongs_to :actual_address, :class_name => 'PostalAddress', autosave: true
  validates :new_actual_address, presence: true, associated: true, if: -> { actual_address_type == 'new' }
  validates :old_actual_address, presence: true, associated: true, inclusion: { in: proc {|company| company.somebody.postal_addresses } }, if: -> { actual_address_type == 'old' }
  accepts_nested_attributes_for :actual_address

  validates :name, :inn, :presence => true

  before_validation :before
  after_validation :after

  validates :ownership, :presence => true, :inclusion => { :in => Rails.configuration.company_ownerships.keys }

  def before
    #binding.pry
    # Выставляем пользователя и обратаываем ситуацию, когда только ввели один адрес
    # и выбрали использовать такой же в другом поле
    if legal_address
      legal_address.somebody = somebody
      if legal_address.save
        if actual_address_type == 'old' && self.old_actual_address_id == -1
          self.actual_address = legal_address
          self.old_actual_address = legal_address
        end
      end
    end

    if actual_address
      actual_address.somebody = somebody
      if actual_address.save
        if legal_address_type == 'old' && self.old_legal_address_id == -1
          self.legal_address = actual_address
          self.old_legal_address = actual_address
        end
      end
    end

  end

  # Мы не хотим показывать ошибку у адреса, у которого выбрали 'Такой же как и другой'
  # чтобы не акцентрировать внимание пользователя на том поле, которое не содержит ошибки, 
  # а на самом деле ошибка содержится в другом и исправлять нужно там
  def after
    #binding.pry
    # TODO тестами покрыл и доделал до желаемого состояния. Позже зарефакторю
    unless (legal_address_type == 'old' && actual_address_type == "old" && old_legal_address_id == -1 && old_actual_address_id == -1)
      if (legal_address_type == 'new' && actual_address_type == 'old' && old_legal_address.try(:id) == old_actual_address_id && old_actual_address_id == -1) || old_actual_address_id == -1
        errors[:old_actual_address].clear
        self.old_actual_address_id = "-1"
      end

      if (actual_address_type == 'new' && legal_address_type == 'old' && old_actual_address.try(:id) == old_legal_address_id && old_actual_address_id == -1) || old_legal_address_id == -1
        errors[:old_legal_address].clear
        self.old_legal_address_id = "-1"
      end
    end

  end

  def to_label
    "#{inn} - #{name}"

  end


end
