require "test_helper"

class IdValidator::ValidatorTest < Minitest::Test

  def setup
    # 复制的测试假数据，若有雷同，请联系
    @id_card_1 = '440308199901101512'
    @id_card_2 = '610104620927690'
    @id_card_3 = '810000199408230021'
    @id_card_4 = '830000199201300022'
  end

  def test_id_crad_is_valid
    validator = IdValidator::Validator.new

    assert validator.is_valid?(@id_card_1)
    assert validator.is_valid?(@id_card_2)
    assert validator.is_valid?(@id_card_3)
    assert validator.is_valid?(@id_card_4)

    assert_equal false, validator.is_valid?('123456789098765')
    assert_equal false, validator.is_valid?('123456789098765432')
  end

end
