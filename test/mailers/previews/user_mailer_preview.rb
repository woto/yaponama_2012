class UserMailerPreview < ActionMailer::Preview

  def registration_letter_after_ordering
    UserMailer.registration_letter_after_ordering(order, password)
  end

  def letter_after_ordering
    UserMailer.letter_after_ordering(order)
  end

  private

  def password
    'password'
  end

  def user
    OpenStruct.new(to_label: 'User#to_label', email: 'email')
  end

  def products
    [OpenStruct.new(to_label: 'Product#to_label', sell_cost: 1, quantity_ordered: 1)]
  end

  def order
    OpenStruct.new(user: user, products: products, to_label: '123-456-789', created_at: Time.new(2015, 03, 15, 13, 43, 05))
  end

end
