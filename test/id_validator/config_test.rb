require "test_helper"

class IdValidator::ConfigTest < Minitest::Test

  def test_should_get_the_config
    address_info = IdValidator::Config.address_info
    abandoned_address_code = IdValidator::Config.abandoned_address_code
    constellation = IdValidator::Config.constellation
    chinese_zodiac = IdValidator::Config.chinese_zodiac

    assert_kind_of Hash, address_info
    assert_kind_of Hash, abandoned_address_code
    assert_kind_of Hash, constellation
    assert_kind_of Array, chinese_zodiac

    assert address_info
    assert abandoned_address_code
    assert constellation
    assert chinese_zodiac
  end

end
