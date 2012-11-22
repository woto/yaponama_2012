class Admin::Products::OrderedController < Admin::ProductsController
  before_filter do 
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

    unless @products.all?{|product| product.status == 'inorder'}
      redirect_to :back, :alert => 'At least one product not in status inorder'
    end
  end

  def index
    @user = @products.first.user
    @current_debit = @user.account.debit
    @current_credit = @user.account.credit

    @after_credit = @current_credit + @products.inject(0){|sum, product| sum += product.sell_cost * product.quantity_ordered}
    @after_debit = @current_credit * @user.prepayment_percent / 100 + @products.inject(0){|sum, product| sum += product.sell_cost * product.quantity_ordered} * @user.prepayment_percent / 100

  end

  def update
    @products.each do |product|
      product.status = 'ordered'
      unless product.save
        redirect_to :back, :alert => product.errors.full_messages and return
      end
    end

    redirect_to_relative_path('ordered')

  end
end
