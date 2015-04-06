module WelcomesHelper

  # В view сначала вызывается partners, а в нем вызывается поочередно partner, передавая параметры конкретных партнеров
  # каждый вызов partner увеличивает счетчик партнеров и сохраняет лямбду на рендеринг этого партнера, когда нам становится
  # известно общее количество партнеров мы выбираем случайного партнера и делаем call лямбд, передавая туда id партнера,
  # который будет active по-умолчанию.

  class << self
    attr_accessor :partners_counter
    attr_accessor :partners_lambdas
  end

  def partner image, content
    id = WelcomesHelper.partners_counter
    WelcomesHelper.partners_lambdas << lambda {|active_partner_id| render('partner', image: image, content: content, active: id == active_partner_id) }
    WelcomesHelper.partners_counter += 1
  end

  def partners &block
    WelcomesHelper.partners_lambdas = []
    WelcomesHelper.partners_counter = 0
    yield
    active_partner_id = rand(WelcomesHelper.partners_counter)
    WelcomesHelper.partners_lambdas.map do |partner_lambda|
      partner_lambda.call(active_partner_id)
    end.join
  end
end
