# encoding: utf-8
#
class Brand < ActiveRecord::Base
  include Selectable
  include Transactionable
  include BelongsToCreator
  include BrandAttributes
  include CachedBrand

  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }

  has_many :brands, :inverse_of => :brand, :dependent => :destroy
  has_many :cars, :inverse_of => :brand, :dependent => :destroy
  has_many :models, :inverse_of => :brand, :dependent => :destroy
  has_many :spare_infos, dependent: :destroy
  has_many :spare_applicabilities, dependent: :destroy
  has_many :products

  # TODO Написать для этого тест(?!)
  validate do
    if brand.try(:brand).present?
      errors[:base] << 'Нельзя указывать в качестве производителя синоним'
    end
  end

  validate do
    if brand == self
      errors[:brand] << 'Нельзя указывать в качестве родительского производителя себя'
    end
  end

  def to_label
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  before_validation :upcase_name

  def upcase_name
    self.name = name.to_s.mb_chars.upcase
  end

  after_update :rebuild

  def rebuild

    # Стоит не забывать, что если такая деталь уже есть (например делаем у KI родителем производителя KIA).
    # И есть в обоих случаях деталь 2102 (KI) и 2102 (KIA). То валидация на уникальность в Описаниях не пропустит.
    # В связи с этим Замены и Применимость так же останутся в лимбе.

    # Мы вызываем сохранение кешированных версий ассоциаций, где имеется brand, из-за того, что там
    # практически везде используется accepts_nested_attributes_for, который пытается сохранить бренд
    # исходя из того, что в нем присутствуют изменения мы прилетаем сюда и в конце как правило вылетаем 
    # по stack overflow, поэтому используем #clear_changes_information

    # Если изменения в name
    if changes[:name]

      clear_changes_information

      spare_infos.each {|s| s.save}
      cars.each {|c| c.save}
      models.each {|m| m.save}
      products.each {|p| p.save}
      spare_applicabilities.each{|s| s.save}
      brands.each {|b| b.save}

    # Иначе если изменения в brand_id
    # и выставили родительский бренд
    elsif changes[:brand_id] && !brand.nil?

      clear_changes_information

      spare_infos.each {|s| s.update(brand: brand)}
      cars.each {|c| c.update(brand: brand)}
      models.each {|m| m.update(brand: brand)}
      products.each {|p| p.update(brand: brand)}
      spare_applicabilities.each{|s| s.update(brand: brand)}
      brands.each {|b| b.update(brand: brand)}

    end

  end

end
