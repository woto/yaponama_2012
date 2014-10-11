require 'test_helper'

class SpareReplacementTest < ActiveSupport::TestCase

  test 'У создавшегейся записи должны быть заполнены кешированные значения' do
    sr = SpareReplacement.create(from_spare_info: spare_infos(:infiniti_3310), to_spare_info: spare_infos(:toyota_3310))
    assert_equal "3310 (INFINITI)", sr.from_cached_spare_info
    assert_equal "3310 (TOYOTA)", sr.to_cached_spare_info
  end

end
