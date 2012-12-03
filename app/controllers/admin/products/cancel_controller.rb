class Admin::Products::CancelController < Admin::ProductsController

  before_filter do 
    raise 'TODO rewrite'
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

    # Финансовый вопрос не важен если товар находится в статусах incart или inorder
    if @products.all?{|p| ["incart", "inorder"].include? p.status}
      return
    end

    #if @products.any? {|product| product.status == "cancel" }
    #  redirect_to :back, :alert => "At least one of the products in cancel status" and return
    #end

    ## Может отсутствовать поставщик когда в отказ с статуса ordered например
    #if @products.any?(&:supplier)
    #  if ( errors = products_belongs_to_one_supplier_validation(@products) ).present?
    #    redirect_to :back, :alert => errors and return
    #  end
    #end
  end


  def index
    @products_sell_cost = @products.inject(0){|summ, p| summ += p.sell_cost * p.quantity_ordered}
    @products_buy_cost = @products.inject(0){|summ, p| summ += p.buy_cost * p.quantity_ordered}
  end


  def create
    supplier_credit = params[:supplier_credit].to_d
    supplier_debit = params[:supplier_debit].to_d

    ActiveRecord::Base.transaction do
      @products.each do |product|
        product.status = 'cancel'
        product.status_will_change!
        unless product.save
          redirect_to :back, :alert => product.errors.full_messages and return
        end
      end

      #if @products.any?(&:supplier)
      #  @products.first.supplier.account.credit -= supplier_credit
      #  @products.first.supplier.account.debit -= supplier_debit
      #  @products.first.supplier.account.save
      #end

    end

    redirect_to_relative_path('cancel')

  end
end
