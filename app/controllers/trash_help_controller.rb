class TrashHelpController < ApplicationController
  def index

  end

  def check_orders_inorder
    user = User.find(params[:user_id])
    user.check_orders
  end

  def make_order
    raise '1'
  end

  def make_payment_to_supplier
    supplier = Supplier.find(params[:supplier_id])
    supplier.account.debit += params[:money].to_d
    supplier.save
  end

  def make_payment
    user = User.find(params[:user_id])
    user.account.credit = user.account.credit + params[:money].to_d
    #user.documents.build(
    #  :left_account => user.account,
    #  :left_real => true,
    #  :left_money => params[:money],
    #)
    
    user.check_orders
    user.save
  end

  def merge
    user_1 = User.find(params[:id_1])
    user_2 = User.find(params[:id_2])
    user_3 = User.new

    has_many_reflections = User.reflect_on_all_associations(:has_many) 
    has_many_reflections.each do |refl|
    user_3.instance_eval <<EOF
      self.#{refl.name} = user_1.#{refl.name}.map{|assoc| assoc} + user_2.#{refl.name}.map{|assoc| assoc}
EOF

      #if user_1_obj.first.present?
      #  user_3_reflection.send(:<<, user_1_obj.first.dup)
      #  debugger
      #  puts '1'
      #end
      #if user_2_obj.first.present?
      #  user_
      #  user_3.method(refl.name).send(:<<, user_2_obj.first.dup)
      #end
    end

    user_3.ping = Ping.new

    #has_one_reflection = User.reflect_on_all_associations(:has_one)
    #has_one_reflection.each do |refl|
    #  user_1_obj = user_1.send(refl.name)
    #  user_2_obj = user_2.send(refl.name)
    #  user_3.send(refl.name) = user_1_obj
    #  user_3.send(refl.name) = user_2_obj
    #end

    user_3.save
  end

  def clear_session
    render :text => session
    reset_session
  end

end
