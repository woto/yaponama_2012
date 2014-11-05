require 'test_helper'

class SpareCatalogTest < ActiveSupport::TestCase

  test 'Проверяем переименование категории' do
    si = spare_infos(:infiniti_3310)
    sc = spare_catalogs(:pylnik_rulevoi_reiki)

    assert_equal "ПЫЛЬНИК РУЛЕВОЙ РЕЙКИ", si.cached_spare_catalog
    sc.update(name: "РУЛЕВОЙ РЕЙКИ ПЫЛЬНИК")
    assert_equal "РУЛЕВОЙ РЕЙКИ ПЫЛЬНИК", si.reload.cached_spare_catalog

  end

end

