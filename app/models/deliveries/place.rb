# encoding: utf-8
#
class Deliveries::Place < ActiveRecord::Base
  include Selectable

  has_many :variants, dependent: :destroy
  accepts_nested_attributes_for :variants, :reject_if => :all_blank, :allow_destroy => true
  validates :variants, :length => { :minimum => 1 }, if: -> { realize }

  has_many :users

  #belongs_to :option

  validates :vertices, :presence => true
  validates :z_index, numericality: { only_integer: true }
  validates :name, :variants, :presence => true, if: -> { realize }
  ['active', 'inactive'].each do |style|
    instance_eval do
      ['fill_opacity', 'stroke_opacity', 'stroke_weight'].each do |prop|
        validates "#{style}_#{prop}".to_sym, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }, if: -> { realize }
      end
      ['fill_color', 'stroke_color'].each do |prop|
        validates "#{style}_#{prop}".to_sym, css_hex_color: true, if: -> { realize }
      end
    end
  end

end
