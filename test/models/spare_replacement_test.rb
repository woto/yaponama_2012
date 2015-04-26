require 'test_helper'

class SpareReplacementTest < ActiveSupport::TestCase

  test 'У создавшейся записи должны быть заполнены кешированные значения' do
    sr = SpareReplacement.create!(from_spare_info: spare_infos(:infiniti_3310), to_spare_info: spare_infos(:toyota_3310), status: :same_number, wrong: false)
    assert_equal "3310 (INFINITI)", sr.from_spare_info.to_label
    assert_equal "3310 (TOYOTA)", sr.to_spare_info.to_label
  end

end
