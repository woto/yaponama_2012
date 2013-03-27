class Company < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser

  attr_accessor :legal_address_type, :actual_address_type

  belongs_to :legal_address, :class_name => 'PostalAddress'
  validates :legal_address, :presence => true
  accepts_nested_attributes_for :legal_address

  belongs_to :actual_address, :class_name => 'PostalAddress'
  validates :actual_address, :presence => true
  accepts_nested_attributes_for :actual_address

  validates :name, :inn, :presence => true

  before_validation :before
  after_validation :after

  def before

    # Выставляем пользователя и обратаываем ситуацию, когда только ввели один адрес
    # и выбрали использовать такой же в другом поле
    if legal_address
      legal_address.user = user
      if legal_address.save
        if actual_address_type == 'old' && self.actual_address_id == -1
          self.actual_address_id = legal_address.id
        end
      end
    end

    if actual_address
      actual_address.user = user
      if actual_address.save
        if legal_address_type == 'old' && self.legal_address_id == -1
          self.legal_address_id = actual_address.id
        end
      end
    end

  end

  # Мы не хотим показывать ошибку у адреса, у которого выбрали 'Такой же как и другой'
  # чтобы не акцентрировать внимание пользователя на том поле, которое не содержит ошибки, 
  # а на самом деле ошибка содержится в другом и исправлять нужно там
  def after
    # TODO Хочется спать, потом буду тесты делать, вот и сделаю как нужно, а пока и так сойдет
    if (legal_address_type == 'new' && actual_address_type == 'old' && legal_address.id == actual_address_id && actual_address_id == -1) || actual_address_id == -1
      errors[:actual_address].clear
      self.actual_address_id = "-1"
    end

    if (actual_address_type == 'new' && legal_address_type == 'old' && actual_address.id == legal_address_id && actual_address_id == -1) || legal_address_id == -1
      errors[:legal_address].clear
      self.legal_address_id = "-1"
    end

  end

  #def manage_virtuals
  #  if legal_address.blank?
  #    build_legal_address
  #    self.valid?
  #    legal_address.errors.clear
  #  end

  #  if actual_address.blank?
  #    if legal_address.valid?
  #      legal_address.save!
  #      actual_address = legal_address
  #      save!
  #    else
  #      build_actual_address
  #      self.valid?
  #      actual_address.errors.clear
  #    end
  #  end
  #
  #
  #
  #end


end
