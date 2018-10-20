require "test_helper"

class IdValidatorTest < Minitest::Test

  def setup
    # 复制的测试假数据，若有雷同，请联系
    @id_card_1 = '440308199901101512'
    @id_card_2 = '610104620927690'
    @id_card_3 = '810000199408230021'
    @id_card_4 = '830000199201300022'
  end

  def test_it_has_a_version_number
    refute_nil ::IdValidator::VERSION
  end

  def test_id_card_is_valid
    assert IdValidator.is_valid?(@id_card_1)
    assert IdValidator.is_valid?(@id_card_2)
    assert IdValidator.is_valid?(@id_card_3)
    assert IdValidator.is_valid?(@id_card_4)
  end

  def test_get_id_card_info
    res_1 = IdValidator.get_info(@id_card_1)
    res_2 = IdValidator.get_info(@id_card_2)
    res_3 = IdValidator.get_info(@id_card_3)
    res_4 = IdValidator.get_info(@id_card_4)

    assert_kind_of Hash, res_1
    assert_kind_of Hash, res_2
    assert_kind_of Hash, res_3
    assert_kind_of Hash, res_4
  end

  def test_get_fake_id_18
    res_1 = IdValidator.fake_id(true)
    res_2 = IdValidator.fake_id(true, '上海市')
    res_3 = IdValidator.fake_id(true, '南山区', '199301')
    res_4 = IdValidator.fake_id(true, '江苏省', '19930101')
    res_5 = IdValidator.fake_id(true, '厦门市', '19930101', 1)

    assert IdValidator.is_valid?(res_1)
    assert IdValidator.is_valid?(res_2)
    assert IdValidator.is_valid?(res_3)
    assert IdValidator.is_valid?(res_4)
    assert IdValidator.is_valid?(res_5)
  end

  def test_get_fake_id_15
    res_1 = IdValidator.fake_id(false)
    res_2 = IdValidator.fake_id(false, '上海市')
    res_3 = IdValidator.fake_id(false, '南山区', '199301')
    res_4 = IdValidator.fake_id(false, '江苏省', '19930101')
    res_5 = IdValidator.fake_id(false, '厦门市', '19930101', 1)

    assert IdValidator.is_valid?(res_1)
    assert IdValidator.is_valid?(res_2)
    assert IdValidator.is_valid?(res_3)
    assert IdValidator.is_valid?(res_4)
    assert IdValidator.is_valid?(res_5)
  end

  def test_should_upgrade_id
    res = IdValidator.upgrade_id(@id_card_2)

    assert IdValidator.is_valid?(res)
  end

end
