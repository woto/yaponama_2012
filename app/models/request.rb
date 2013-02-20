#encoding: utf-8

class Request < ActiveRecord::Base
  has_paper_trail
  include BelongsToUser

  ANY_DATA = %w(name catalog_number manufacturer notes)

  belongs_to :car
  belongs_to :request

  has_many :requests, :dependent => :destroy
  accepts_nested_attributes_for :requests, :allow_destroy => true

  def to_label
    ANY_DATA.map{|attr| attributes[attr]}.join(' - ')
  end

  validate :any_data?

  def any_data?
    unless (ANY_DATA.any?{|attr| self.attributes[attr].present?})
      errors.add(:base, "Пожалуйста заполните хотя бы какие-нибудь существенные данные по запросу.")
    end
  end

  before_validation :set_relational_attributes
  
  def set_relational_attributes

    if self.car.present?
      self.user = self.car.user
      self.requests.each do |request|
        request.car = self.car
        request.user = self.car.user
      end
    end

    if self.user.present?
      self.requests.each do |request|
        request.user = self.user
      end
    end

  end

end
