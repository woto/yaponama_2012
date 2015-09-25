require 'test_helper'

class SpareReplacementTest < ActiveSupport::TestCase

  test 'У создавшейся записи должны быть заполнены кешированные значения' do
    sr = SpareReplacement.create!(from_spare_info: spare_infos(:infiniti_3310), to_spare_info: spare_infos(:toyota_3310), status: :same_num, wrong: false)
    assert_equal "3310 (INFINITI)", sr.from_spare_info.to_label
    assert_equal "3310 (TOYOTA)", sr.to_spare_info.to_label
  end

  test 'Ни при каких обстоятельствах недопустимо наличие другой замены, где "с" и "на" идентичны' do
    SpareReplacement.create!(from_spare_info: spare_infos(:infiniti_3310), to_spare_info: spare_infos(:toyota_3310), status: :same_num, wrong: false)
    sr = SpareReplacement.create(from_spare_info: spare_infos(:infiniti_3310), to_spare_info: spare_infos(:toyota_3310), status: :same_num, wrong: false)
    refute sr.persisted?
    assert_equal ['уже существует'], sr.errors['from_spare_info']
    assert_equal ['уже существует'], sr.errors['to_spare_info']
  end

  test 'Ни при каких обстоятельствах недопустима замена, где "с" и "на" идентичны' do
    sr = SpareReplacement.create(from_spare_info: spare_infos(:infiniti_3310), to_spare_info: spare_infos(:infiniti_3310), status: :same_num, wrong: false)
    refute sr.persisted?
    assert_equal ['товары идентичны, выберите другой'], sr.errors[:base]
  end

  test 'Недопустимо создание замен со статусами new_num, same_num, part_num если уже имеется зеркальная с любым статусом' do
    ['new_num', 'same_num', 'repl_num', 'part_num'].each do |sr1_status|
      sr1 = SpareReplacement.create!(from_spare_info: spare_infos(:infiniti_3310), to_spare_info: spare_infos(:toyota_3310), status: sr1_status, wrong: false)
      ['new_num', 'same_num', 'part_num'].each do |sr2_status|
        sr2 = SpareReplacement.create(from_spare_info: spare_infos(:toyota_3310), to_spare_info: spare_infos(:infiniti_3310), status: sr2_status, wrong: false)
        refute sr2.persisted?
        assert_equal ['невозможно сохранить замену, т.к. существует дубликат'], sr2.errors['base']
      end
      sr1.destroy!
    end
  end

  test 'Недопустимо создание замен со статусом repl_num, если уже имеется зеркальная со статусами new_num, same_num, part_num' do
    ['new_num', 'same_num', 'part_num'].each do |sr1_status|
      sr1 = SpareReplacement.create!(from_spare_info: spare_infos(:infiniti_3310), to_spare_info: spare_infos(:toyota_3310), status: sr1_status, wrong: false)
      ['repl_num'].each do |sr2_status|
        sr2 = SpareReplacement.create(from_spare_info: spare_infos(:toyota_3310), to_spare_info: spare_infos(:infiniti_3310), status: sr2_status, wrong: false)
        refute sr2.persisted?
        assert_equal ['невозможно сохранить замену, т.к. существует дубликат'], sr2.errors['base']
      end
      sr1.destroy!
    end
  end

end
