# encoding: utf-8
#
class ItemCollection < AbstractCollection

  attr_accessor :operation

  # Для post_supplier
  attr_accessor :supplier
  validates :supplier, :presence => true, if: -> { ['post_supplier_action'].include? operation }

  #
  # Выделен хотя бы один
  validate if: -> { ['incart', 'inorder', 'ordered', 'pre_supplier', 'post_supplier', 'post_supplier_action', 'stock', 'complete', 'cancel', 'multiple_destroy' ].include? operation } do
    any_item
  end

  validate do
    case operation
    when *['incart']
      all_status_validation 'incart', 'inorder', 'ordered', 'pre_supplier'
    when *['inorder', 'inorder_action']
      all_status_validation 'incart', 'inorder', 'ordered', 'pre_supplier'
    when *['ordered']
      all_status_validation 'inorder'
    when *['pre_supplier']
      all_status_validation 'ordered', 'pre_supplier', 'post_supplier', 'stock'
    when *['post_supplier', 'post_supplier_action']
      all_status_validation 'pre_supplier'
    when *['stock']
      all_status_validation 'post_supplier', 'complete'
    when *['complete']
      all_status_validation 'stock'
    when *['multiple_destroy']
      all_status_validation 'cancel'
    end
  end


  def operate
    ActiveRecord::Base.transaction do
      if valid?
        case operation
        when 'incart'
          items.each do |item|
            item.status = 'incart'
            item.save!
          end
        when 'inorder'
          items.each do |item|
            item.status = 'inorder'
            item.save!
          end
        when 'ordered'
          items.each do |item|
            item.status = 'ordered'
            item.save!
          end
        when 'pre_supplier'
          items.each do |item|
            item.status = 'pre_supplier'
            item.save!
          end
        when 'post_supplier'
          true
        when 'post_supplier_action'
          items.each do |item|
            item.supplier_id = supplier
            item.status = 'post_supplier'
            item.save!
          end
        when 'stock'
          items.each do |item|
            item.status = 'stock'
            item.save!
          end
        when 'complete'
          items.each do |item|
            item.status = 'complete'
            item.save!
          end
        when 'cancel'
          items.each do |item|
            item.status = 'cancel'
            item.save!
          end
        when 'multiple_destroy'
          items.each do |item|
            item.destroy!
          end
        end
      end
    end
  end

  private

  # Проверка допустимости статуса
  def all_status_validation *valid_statuses
    result = []
    items.all? do |item| 
      unless valid_statuses.include? item.status 
        result << item.status
      end
    end

    if result.any?
      errors.add(:base, "Данное действие невозможно осуществить для позиций, находящихся в статусе: '#{result.uniq.map{|status| '"' + Rails.configuration.products_status[status]['title'] + '"'}.join(', ')}'. Допустимые исходные статусы только #{valid_statuses.map{|status| '"' + Rails.configuration.products_status[status]['title'] + '"'}.join(', ')}")
    end

  end

end
