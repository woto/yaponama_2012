class Brand < ActiveRecord::Base

  include ByCategoryConcern
  include BelongsToCreator
  include Concerns::BrandAttributes

  enum sign: [:slang, :synonym, :conglomerate]

  mount_uploader :image, BrandUploader

  validates :name, :presence => true, uniqueness:  { case_sensitive: false }

  has_and_belongs_to_many :spare_catalogs
  has_many :brands, :inverse_of => :brand, :dependent => :destroy
  has_many :cars, :inverse_of => :brand, :dependent => :destroy
  has_many :models, :inverse_of => :brand, :dependent => :destroy
  has_many :spare_infos, dependent: :destroy
  has_many :spare_applicabilities, dependent: :destroy
  has_many :products

  validate do
    if brand == self
      errors[:brand] << 'Нельзя указывать в качестве родительского производителя себя'
    end
  end

  validate do
    if self.name == brand.try(:name)
      errors[:brand] << 'имя родительского бренда должно отличаться от создаваемого'
    end
  end

  validate do
    if sign.nil? ^ brand.nil?
      errors[:base] << 'В случае когда заполняется родительский бренд или признак принадлежности родительскому бренду, то должен быть заполнен и второй параметр'
    end
  end

  validate do
    if sign.in?(["slang", "synonym"]) && is_brand?
      errors[:base] << 'slang или synonym не может быть is_brand'
    end
  end

  validate do
    if brand && brand.sign.in?(['slang', 'synonym'])
      errors[:base] << 'В качестве родителя нельзя выбирать бренд, у которого выставлен slang или synonym'
    end
  end

  validate do
    if sign == 'conglomerate' && brand && brand.sign == 'conglomerate'
      errors[:base] << 'У conglomerate не может быть родительский бренд, у которого так же выставлен conglomerate'
    end
  end

  # TODO Еще подумать на валидацией, например в цепочке не может быть 2 конгломерата.
  # А так же можно попасть в просак, играя с цепочками и назначениями родительских брендов и is_brand,
  # но по идее поправив is_brand и запустив повторно задачу можно решить вопрос

  def to_label
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  after_save :brand_rebuild, if: ->{changes[:brand_id] && !brand.nil?}

  def brand_rebuild
    BrandChainJob.perform_later brand
  end

end
