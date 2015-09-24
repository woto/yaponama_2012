require 'test_helper'

class BrandChainJobTest < ActiveJob::TestCase

  def setup
    @ki = brands(:ki)
    @kia = brands(:kia)
    @hy = brands(:hy)
    @hyundai = brands(:hyundai)
    @kia_hyundai = Brand.create!(name: 'KIA HYUNDAI')
  end

  test 'Если назначили родительский бренд, то должна добавиться в очередь задача' do
    brand1 = Brand.create(name: 'Brand 1')
    brand2 = Brand.create(name: 'Brand 2')
    assert_enqueued_with(job: BrandChainJob) do
      brand1.update!(brand: brand2, sign: 'synonym')
    end
  end

  test 'Проверяем присвоение родительского производителя (другие тесты опираются на эти условия)' do
    assert_equal nil, @ki.brand
    @ki.update!(brand: @kia, sign: 'synonym')
    assert_equal @kia, @ki.reload.brand
  end

  test 'SpareInfo. Проверяем успешную смену бренда' do
    ki_2103 = spare_infos(:ki_2103)
    assert_equal @ki, ki_2103.brand
    @ki.update!(brand: @kia, sign: 'synonym')
    BrandChainJob.perform_now(@ki)
    assert_equal @kia, ki_2103.reload.brand
  end

  test 'SpareInfo. Проверяем работу цепочки производителей. KI -> KIA -> KIA HYUNDAI' do
    ki_2103 = spare_infos(:ki_2103)
    assert_equal @ki, ki_2103.brand
    @kia.update!(brand: @kia_hyundai, sign: 'conglomerate')
    @ki.update!(brand: @kia, sign: 'synonym')
    BrandChainJob.perform_now(@ki)
    assert_equal @kia_hyundai, ki_2103.reload.brand
  end

  test 'SpareInfo. Проверяем невозможность смены бренда, т.к. такой SpareInfo уже имеется' do
    ki_2102 = spare_infos(:ki_2102)
    assert_equal @ki, ki_2102.brand
    @ki.update!(brand: @kia, sign: 'synonym')
    BrandChainJob.perform_now(@ki)
    assert_equal @ki, ki_2102.reload.brand
  end

  test 'Product. Проверяем успешную смену бренда.' do
    ki_2103 = products(:ki_2103)
    assert_equal @ki, ki_2103.brand
    @ki.update!(brand: @kia, sign: 'synonym')
    BrandChainJob.perform_now(@ki)
    assert_equal @kia, ki_2103.reload.brand
  end

  test 'Product. Проверяем работу цепочки производителей. KI -> KIA -> KIA HYUNDAI' do
    ki_2103 = products(:ki_2103)
    assert_equal @ki, ki_2103.brand
    @kia.update!(brand: @kia_hyundai, sign: 'conglomerate')
    @ki.update!(brand: @kia, sign: 'synonym')
    BrandChainJob.perform_now(@ki)
    assert_equal @kia_hyundai, ki_2103.reload.brand
  end

  test 'Model. Проверяем успешную смену бренда' do
    hy_solaris = models(:hy_solaris)
    assert_equal @hy, hy_solaris.brand
    @hy.update!(brand: @hyundai, sign: 'synonym', is_brand: false)
    BrandChainJob.perform_now(@hy)
    assert_equal @hyundai, hy_solaris.reload.brand
  end

  test 'Model. Проверяем работу цепочки производителей HY -> HYNDAI -> KIA HYUNDAI' do
    hy_solaris = models(:hy_solaris)
    assert_equal @hy, hy_solaris.brand
    @hyundai.update!(brand: @kia_hyundai, sign: 'conglomerate')
    @hy.update!(brand: @hyundai, sign: 'synonym', is_brand: false)
    BrandChainJob.perform_now(@hy)
    assert_equal @hyundai, hy_solaris.reload.brand
  end

  test 'Car. Проверяем успешную смену бренда' do
    hy_solaris = cars(:hy_solaris)
    assert_equal @hy, hy_solaris.brand
    @hy.update!(brand: @hyundai, sign: 'synonym', is_brand: false)
    BrandChainJob.perform_now(@hy)
    assert_equal @hyundai, hy_solaris.reload.brand
    assert_equal @hyundai, models(:hy_solaris).brand
  end

  test 'Car. Проверяем работу цепочки производителей HY -> HYUNDAI -> KIA HYUNDAI' do
    hy_solaris = cars(:hy_solaris)
    assert_equal @hy, hy_solaris.brand
    @hyundai.update!(brand: @kia_hyundai, sign: 'conglomerate')
    @hy.update!(brand: @hyundai, sign: 'synonym', is_brand: false)
    BrandChainJob.perform_now(@hy)
    assert_equal @hyundai, hy_solaris.reload.brand
    assert_equal @hyundai, models(:hy_solaris).brand
  end

  test 'SpareApplicability. Проверяем успешную смену бренда' do
    hy_solaris = spare_applicabilities(:hy_solaris)
    assert_equal @hy, hy_solaris.brand
    @hy.update!(brand: @hyundai, sign: 'synonym', is_brand: false)
    BrandChainJob.perform_now(@hy)
    assert_equal @hyundai, hy_solaris.reload.brand
    assert_equal @hyundai, models(:hy_solaris).brand
  end

  test 'SpareApplicability. Проверяем работу цепочки производителей HY -> HYUNDAI -> KIA HYUNDAI' do
    hy_solaris = spare_applicabilities(:hy_solaris)
    assert_equal @hy, hy_solaris.brand
    @hyundai.update!(brand: @kia_hyundai, sign: 'conglomerate')
    @hy.update!(brand: @hyundai, sign: 'synonym', is_brand: false)
    BrandChainJob.perform_now(@hy)
    assert_equal @hyundai, hy_solaris.reload.brand
    assert_equal @hyundai, models(:hy_solaris).brand
  end

end
