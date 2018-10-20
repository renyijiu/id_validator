require "test_helper"

class IdValidator::ValidatorTest < Minitest::Test

  def setup
    # 复制的测试假数据，若有雷同，请联系
    @id_card_1 = '440308199901101512'
    @id_card_2 = '610104620927690'
    @id_card_3 = '810000199408230021'
    @id_card_4 = '830000199201300022'
  end

  def test_id_card_is_valid
    validator = IdValidator::Validator.new

    assert validator.is_valid?(@id_card_1)
    assert validator.is_valid?(@id_card_2)
    assert validator.is_valid?(@id_card_3)
    assert validator.is_valid?(@id_card_4)

    assert_equal false, validator.is_valid?('123456789098765')
    assert_equal false, validator.is_valid?('123456789098765432')
  end

  def test_should_get_info_1
    validator = IdValidator::Validator.new
    info = validator.get_info(@id_card_1)

    assert_kind_of Hash, info
    assert_equal '440308', info[:address_code]
    assert_equal '广东省深圳市盐田区', info[:address]
    assert_equal false, info[:abandoned]
    assert_equal '1999-01-10', info[:birthday_code]
    assert_equal '摩羯座', info[:constellation]
    assert_equal '卯兔', info[:chinese_zodiac]
    assert_equal 1, info[:sex]
    assert_equal 18, info[:length]
    assert_equal '2', info[:check_bit]
  end

  def test_should_get_info_2
    validator = IdValidator::Validator.new
    info = validator.get_info(@id_card_2)

    assert_kind_of Hash, info
    assert_equal '610104', info[:address_code]
    assert_equal '陕西省西安市莲湖区', info[:address]
    assert_equal false, info[:abandoned]
    assert_equal '1962-09-27', info[:birthday_code]
    assert_equal '天秤座', info[:constellation]
    assert_equal '寅虎', info[:chinese_zodiac]
    assert_equal 0, info[:sex]
    assert_equal 15, info[:length]
    assert_equal '', info[:check_bit]
  end

  def test_should_get_info_3
    validator = IdValidator::Validator.new
    info = validator.get_info(@id_card_3)

    assert_kind_of Hash, info
    assert_equal '810000', info[:address_code]
    assert_equal '香港特别行政区', info[:address]
    assert_equal false, info[:abandoned]
    assert_equal '1994-08-23', info[:birthday_code]
    assert_equal '处女座', info[:constellation]
    assert_equal '戌狗', info[:chinese_zodiac]
    assert_equal 0, info[:sex]
    assert_equal 18, info[:length]
    assert_equal '1', info[:check_bit]
  end

  def test_should_get_info_4
    validator = IdValidator::Validator.new
    info = validator.get_info(@id_card_4)

    assert_kind_of Hash, info
    assert_equal '830000', info[:address_code]
    assert_equal '台湾省', info[:address]
    assert_equal false, info[:abandoned]
    assert_equal '1992-01-30', info[:birthday_code]
    assert_equal '水瓶座', info[:constellation]
    assert_equal '申猴', info[:chinese_zodiac]
    assert_equal 0, info[:sex]
    assert_equal 18, info[:length]
    assert_equal '2', info[:check_bit]
  end

  def test_should_get_fake_id_15
    validator = IdValidator::Validator.new

    res_1 = validator.fake_id(false)
    res_2 = validator.fake_id(false, '上海市')
    res_3 = validator.fake_id(false, '南山区', '199301')
    res_4 = validator.fake_id(false, '江苏省', '19930101')
    res_5 = validator.fake_id(false, '厦门市', '19930101', 1)

    assert validator.is_valid?(res_1)
    assert validator.is_valid?(res_2)
    assert validator.is_valid?(res_3)
    assert validator.is_valid?(res_4)
    assert validator.is_valid?(res_5)
  end

  def test_should_get_fake_id_18
    validator = IdValidator::Validator.new

    res_1 = validator.fake_id(true)
    res_2 = validator.fake_id(true, '上海市')
    res_3 = validator.fake_id(true, '南山区', '199301')
    res_4 = validator.fake_id(true, '江苏省', '19930101')
    res_5 = validator.fake_id(true, '厦门市', '19930101', 1)

    assert validator.is_valid?(res_1)
    assert validator.is_valid?(res_2)
    assert validator.is_valid?(res_3)
    assert validator.is_valid?(res_4)
    assert validator.is_valid?(res_5)
  end

  def test_should_upgrade_id_15
    validator = IdValidator::Validator.new

    res = validator.upgrade_id(@id_card_2)

    assert_equal 18, res.length
    assert validator.is_valid?(res)
  end

  def test_should_upgrade_id_18
    validator = IdValidator::Validator.new

    res = validator.upgrade_id(@id_card_1)

    assert_equal false, res
  end
end
