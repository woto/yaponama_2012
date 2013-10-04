# encoding: utf-8

#http://ahhrrr.com/2012/08/02/quick-tip-test-custom-activerecord-validators/
#http://jeffkreeftmeijer.com/2011/isolated-testing-for-custom-validators-in-rails-3/
#http://stackoverflow.com/questions/7744171/how-to-test-a-custom-validator
#TODO протестировать, возможно когда перейду на Rspec
class EmailValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)

    if object.errors[:value].blank?

      unless value =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        object.errors[attribute] << (options[:message] || "имеет неверное значение")
      end

    end

  end

end

