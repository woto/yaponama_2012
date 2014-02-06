# encoding: utf-8
#
class ItemCollection < AbstractCollection

  attr_accessor :somebody

  attr_accessor :operation

  # Для post_supplier
  attr_reader :supplier_id
  attr_accessor :supplier

  def supplier_id=(supplier_id)
    if supplier_id.present?
      self.supplier = Supplier.find(supplier_id)
    end
  end

  validates :supplier, :presence => true, if: -> { ['post_supplier_action'].include? operation }

  # Выделен хотя бы один
  validate if: -> { ['incart', 'inorder', 'inorder_action', 'ordered', 'pre_supplier', 'post_supplier', 'post_supplier_action', 'stock', 'complete', 'cancel', 'multiple_destroy' ].include? operation } do
    any_item
  end

  attr_writer :user

  def user
    somebody = items.try(:first).try(:somebody)
    # TODO ВЕРНУТЬ! УБИРАЛ ДЛЯ PAGES
    if somebody
      if items.all?{|item| item.somebody == somebody}
        somebody
      end
    end
  end

  # Для inorder
  def order_id=(order_id)
    #binding.pry
    if order_id == '-1'
      self.order = self.user.orders.new
    elsif order_id.present?
      self.order = self.user.orders.find(order_id)
    end
  end

  attr_reader :order_id
  attr_accessor :order

  validates :order, :presence => true, if: -> { ['inorder_action'].include? operation }

  # Товар принадлежит одному покупателю
  validate if: -> {['inorder'].include? operation } do
    if errors.empty?
      errors.add(:base, 'Выбранные позиции принадлежат разным пользователям') unless user
    end
  end

  validate do
    #binding.pry
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
    when *['cancel']
      true
    else
      raise 'Необходимо добавть валидацию переходимого статуса'
    end
  end


  def operate
    ActiveRecord::Base.transaction do
      #binding.pry
      if valid?
        case operation
        when 'incart'
          items.each do |item|
            item.status = 'incart'
            item.save!
          end
        when 'inorder'
          true
        when 'inorder_action'
          items.each do |item|
            item.status = 'inorder'
            item.order = order
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
            item.supplier = supplier
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
    return
    # TODO АХТУНГ!!!
    result = []
    items.each do |item|
      unless valid_statuses.include? item.status 
        result << item.status
      end
    end

    if result.any?
      errors.add(:base, "Данное действие невозможно осуществить для позиций, находящихся в статусе: '#{result.uniq.map{|status| '"' + Rails.configuration.products_status[status]['title'] + '"'}.join(', ')}'. Допустимые исходные статусы только #{valid_statuses.map{|status| '"' + Rails.configuration.products_status[status]['title'] + '"'}.join(', ')}")
    end

  end

  ## Проверка принадлежности товаров одному покупателю
  #def products_belongs_to_one_user_validation

  #  items.each do |item|
  #    unless item.somebody == user
  #      errors.add(:base, "Выбранные позиции должны принадлежать одному покупателю, а сейчас: '#{item.somebody.to_label}' и '#{user.to_label}'")
  #    end
  #  end

  #end





  



    ## Проверка принадлежности товаров одному покупателю
    #def products_belongs_to_one_user_validation!

    #  first_user = @items.first.user

    #  @items.each do |item|
    #    unless item.user == first_user
    #      raise ValidationError.new "Выбранные позиции должны принадлежать одному покупателю, а сейчас: '#{item.user.to_label}' и '#{first_user.to_label}'"
    #    end
    #  end

    #  @user = @items.first.user


    #end






    ## Проверка наличия у всех позиций поставщиков и принадлежности позиций одному поставщику
    #def products_belongs_to_one_supplier_validation!

    #  unless @items.all?{|p| p.supplier}
    #    raise ValidationError.new "Как минимум одна из позиций не имеет поставщика. Невозможно обрабатывать одновременно товары у которых указан поставщик и у которых нет."
    #    return errors
    #  end

    #  first_supplier = @items.first.supplier

    #  @items.each do |item|
    #    unless item.supplier == first_supplier
    #      raise ValidationError.new "Позиции должны принадлежать одному поставщику, а сейчас: '#{item.supplier.to_label}' и '#{first_supplier.to_label}'"
    #    end
    #  end

    #end

end
