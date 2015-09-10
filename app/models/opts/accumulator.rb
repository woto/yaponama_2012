class Opts::Accumulator < ActiveRecord::Base

  include BelongsToCreator
  belongs_to :spare_info

  validates :spare_info, presence: true

  ['voltage', 'terminal_types', 'base_hold_down', 'layout'].each do |name|
    instance_eval "validates :#{name}, inclusion: { in: Rails.configuration.opts_accumulator['accumulator_#{name}']['checkboxes'].map{|arr| arr[:value].to_i} }"
  end

  ['battery_capacity', 'cold_cranking_amps', 'length', 'width', 'height'].each do |name|
    instance_eval "validates :#{name}, numericality: { only_integer: true, greater_than_or_equal_to: Rails.configuration.opts_accumulator['accumulator_#{name}']['range'][:min].to_i, less_than_or_equal_to: Rails.configuration.opts_accumulator['accumulator_#{name}']['range'][:max].to_i }"
  end

end
