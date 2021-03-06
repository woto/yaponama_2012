class Deliveries::Place < ActiveRecord::Base

  has_many :variants, dependent: :destroy
  accepts_nested_attributes_for :variants, :reject_if => :all_blank, :allow_destroy => true
  validates :variants, :length => { :minimum => 1 }, if: -> { realize }

  has_many :users
  has_many :warehouses, class_name: "Warehouse", dependent: :destroy

  #belongs_to :option

  def to_label
    name
  end

  validates :vertices, :presence => true
  validates :z_index, numericality: { only_integer: true }
  validates :name, :variants, :presence => true, if: -> { realize }

  with_options presence: true, if: -> {display_marker?} do |attribute|
    attribute.validates :price_url
    attribute.validates :faq_id
    attribute.validates :email
  end

  def self.random_list
    where(display_marker: true, active: true, partner: false).order("RANDOM()")
  end

end
