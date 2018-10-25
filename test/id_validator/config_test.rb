require "test_helper"

class IdValidator::ConfigTest < Minitest::Test

  def test_should_get_the_config
    total_address_info = IdValidator::Config.total_address_info
    latest_address_info = IdValidator::Config.latest_address_info
    constellation = IdValidator::Config.constellation
    chinese_zodiac = IdValidator::Config.chinese_zodiac

    assert_kind_of Hash, total_address_info
    assert_kind_of Hash, latest_address_info
    assert_kind_of Hash, constellation
    assert_kind_of Array, chinese_zodiac

    assert total_address_info
    assert latest_address_info
    assert constellation
    assert chinese_zodiac
  end

end
