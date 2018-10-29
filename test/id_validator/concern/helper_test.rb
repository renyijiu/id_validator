require "test_helper"

class IdValidator::Concern::HelperTest < Minitest::Test

  def setup
    # 复制的测试假数据，若有雷同，请联系
    @id_card_1 = '440308199901101512'
    @id_card_2 = '610104620927690'
    @id_card_3 = '810000199408230021'
    @id_card_4 = '830000199201300022'

    @object = Object.new
    @object.extend(IdValidator::Concern::Helper)
  end

  def test_func_check_birthday
    res = IdValidator::Concern::Func.check_birthday('20181015')
    assert_equal true, res

    res = IdValidator::Concern::Func.check_birthday('17991015')
    assert_equal false, res

    res = IdValidator::Concern::Func.check_birthday('20181035')
    assert_equal false, res

    res = IdValidator::Concern::Func.check_birthday('2018101512')
    assert_equal false, res

    res = IdValidator::Concern::Func.check_birthday('25001001')
    assert_equal false, res
  end

  def test_should_format_birthday
    res = IdValidator::Concern::Func.format_birthday_code('20181015')

    assert_equal '2018-10-15', res
  end

  def test_should_format_address
    address_info = {
        province: '陕西省',
        city: '西安市',
        district: '莲湖区'
    }

    res = IdValidator::Concern::Func.format_address_info(address_info)
    assert_equal ['陕西省', '西安市', '莲湖区'], res
  end

  def test_func_random_address_code
    reg = %r(^\d{4}(?!00)\d{2}$)
    res = IdValidator::Concern::Func.get_random_address_code(reg)

    assert_match reg, res
  end

  def test_func_get_str_pad
    str = 'hello'
    res_1 = IdValidator::Concern::Func.get_str_pad(str, 10)
    res_2 = IdValidator::Concern::Func.get_str_pad(str, 10, '0', false)

    assert_equal 'hello00000', res_1
    assert_equal '00000hello', res_2
  end

  def test_func_get_random_num
    res_1 = IdValidator::Concern::Func.get_random_right_num(1, 1, 10)
    res_2 = IdValidator::Concern::Func.get_random_right_num(0, 1, 10)
    res_3 = IdValidator::Concern::Func.get_random_right_num(5, 1, 10)
    res_4 = IdValidator::Concern::Func.get_random_right_num(10, 1, 10)
    res_5 = IdValidator::Concern::Func.get_random_right_num(15, 1, 10)

    assert (1..10).include?(res_1)
    assert (1..10).include?(res_2)
    assert (1..10).include?(res_3)
    assert (1..10).include?(res_4)
    assert (1..10).include?(res_5)
  end

  def test_func_get_random_birthday
    res = IdValidator::Concern::Func.get_random_birthday_code

    assert IdValidator::Concern::Func.check_birthday(res)
  end

  def test_func_get_address_info
    code = IdValidator::Config.latest_address_info.keys.sample
    res = IdValidator::Concern::Func.get_address_info(code)

    assert_equal IdValidator::Config.latest_address_info.fetch(code), res
  end

  def test_should_get_id_argument_1
    code = @object.get_id_argument(@id_card_1)

    assert_equal @id_card_1[0...17], code[:body]
    assert_equal @id_card_1[0...6], code[:address_code]
    assert_equal @id_card_1[6...14], code[:birthday_code]
    assert_equal @id_card_1[14...17], code[:order_code]
    assert_equal @id_card_1[17], code[:check_bit]
    assert_equal 18, code[:type]
  end

  def test_should_get_id_argument_2
    code = @object.get_id_argument(@id_card_2)

    assert_equal @id_card_2, code[:body]
    assert_equal @id_card_2[0...6], code[:address_code]
    assert_equal '19' + @id_card_2[6...12], code[:birthday_code]
    assert_equal @id_card_2[12...15], code[:order_code]
    assert_equal '', code[:check_bit]
    assert_equal 15, code[:type]
  end

  def test_should_get_id_argument_3
    code = @object.get_id_argument(@id_card_3)

    assert_equal @id_card_3[0...17], code[:body]
    assert_equal @id_card_3[0...6], code[:address_code]
    assert_equal @id_card_3[6...14], code[:birthday_code]
    assert_equal @id_card_3[14...17], code[:order_code]
    assert_equal @id_card_3[17], code[:check_bit]
    assert_equal 18, code[:type]
  end

  def test_should_get_id_argument_4
    code = @object.get_id_argument(@id_card_4)

    assert_equal @id_card_4[0...17], code[:body]
    assert_equal @id_card_4[0...6], code[:address_code]
    assert_equal @id_card_4[6...14], code[:birthday_code]
    assert_equal @id_card_4[14...17], code[:order_code]
    assert_equal @id_card_4[17], code[:check_bit]
    assert_equal 18, code[:type]
  end

  def test_should_get_address_info_1
    info = @object.get_address_info(@id_card_1[0...6])

    assert_equal '广东省', info[:province]
    assert_equal '深圳市', info[:city]
    assert_equal '盐田区', info[:district]
  end

  def test_should_get_address_info_2
    info = @object.get_address_info(@id_card_2[0...6])

    assert_equal '陕西省', info[:province]
    assert_equal '西安市', info[:city]
    assert_equal '莲湖区', info[:district]
  end

  def test_should_get_address_info_3
    info = @object.get_address_info(@id_card_3[0...6])

    assert_equal '香港特别行政区', info[:province]
    assert_nil info[:city]
    assert_nil info[:district]
  end

  def test_should_get_address_info_4
    info = @object.get_address_info(@id_card_4[0...6])

    assert_equal '台湾省', info[:province]
    assert_nil info[:city]
    assert_nil info[:district]
  end

  def test_should_get_constellation
    assert_equal '摩羯座', @object.get_constellation('20180119')
    assert_equal '水瓶座', @object.get_constellation('20180120')
    assert_equal '水瓶座', @object.get_constellation('20180218')
    assert_equal '双鱼座', @object.get_constellation('20180219')
    assert_equal '双鱼座', @object.get_constellation('20180320')
    assert_equal '白羊座', @object.get_constellation('20180321')
    assert_equal '白羊座', @object.get_constellation('20180419')
    assert_equal '金牛座', @object.get_constellation('20180420')
    assert_equal '金牛座', @object.get_constellation('20180520')
    assert_equal '双子座', @object.get_constellation('20180521')
    assert_equal '双子座', @object.get_constellation('20180621')
    assert_equal '巨蟹座', @object.get_constellation('20180622')
    assert_equal '巨蟹座', @object.get_constellation('20180722')
    assert_equal '狮子座', @object.get_constellation('20180723')
    assert_equal '狮子座', @object.get_constellation('20180822')
    assert_equal '处女座', @object.get_constellation('20180823')
    assert_equal '处女座', @object.get_constellation('20180922')
    assert_equal '天秤座', @object.get_constellation('20180923')
    assert_equal '天秤座', @object.get_constellation('20181023')
    assert_equal '天蝎座', @object.get_constellation('20181024')
    assert_equal '天蝎座', @object.get_constellation('20181122')
    assert_equal '射手座', @object.get_constellation('20181123')
    assert_equal '射手座', @object.get_constellation('20181221')
    assert_equal '摩羯座', @object.get_constellation('20181222')
  end

  def test_should_get_chinese_zodiac
    assert_equal '子鼠', @object.get_chinese_zodiac('20080101')
    assert_equal '丑牛', @object.get_chinese_zodiac('20090101')
    assert_equal '寅虎', @object.get_chinese_zodiac('20100101')
    assert_equal '卯兔', @object.get_chinese_zodiac('20110101')
    assert_equal '辰龙', @object.get_chinese_zodiac('20120101')
    assert_equal '巳蛇', @object.get_chinese_zodiac('20130101')
    assert_equal '午马', @object.get_chinese_zodiac('20140101')
    assert_equal '未羊', @object.get_chinese_zodiac('20150101')
    assert_equal '申猴', @object.get_chinese_zodiac('20160101')
    assert_equal '酉鸡', @object.get_chinese_zodiac('20170101')
    assert_equal '戌狗', @object.get_chinese_zodiac('20180101')
    assert_equal '亥猪', @object.get_chinese_zodiac('20190101')
  end

  def test_should_check_address_code
    assert @object.check_address_code(@id_card_1[0...6])
    assert @object.check_address_code(@id_card_2[0...6])
    assert @object.check_address_code(@id_card_3[0...6])
    assert @object.check_address_code(@id_card_4[0...6])

    assert_equal false, @object.check_address_code('')
    assert_equal false, @object.check_address_code('000000')
  end

  def test_should_check_birthday
    assert @object.check_birthday_code(@id_card_1[6...14])
    assert @object.check_birthday_code('19' + @id_card_2[6...12])
    assert @object.check_birthday_code(@id_card_3[6...14])
    assert @object.check_birthday_code(@id_card_4[6...14])

    assert_equal false, @object.check_birthday_code('')
    assert_equal false, @object.check_birthday_code('19991040')
  end

  def test_should_check_order_code
    assert @object.check_order_code(@id_card_1[14...17])
    assert @object.check_order_code(@id_card_2[12...15])
    assert @object.check_order_code(@id_card_3[14...17])
    assert @object.check_order_code(@id_card_4[14...17])

    assert_equal false, @object.check_order_code('')
    assert_equal false, @object.check_order_code('1234')
  end

  def test_should_check_is_abandoned
    assert_equal false, @object.check_is_abandoned(@id_card_1[0...6])
    assert_equal false, @object.check_is_abandoned(@id_card_2[0...6])
    assert_equal false, @object.check_is_abandoned(@id_card_3[0...6])
    assert_equal false, @object.check_is_abandoned(@id_card_4[0...6])

    assert @object.check_is_abandoned('110103')
  end

  def test_should_generate_check_bit
    assert_equal '2', @object.generate_check_bit(@id_card_1[0...17])
    assert_nil @object.generate_check_bit(@id_card_2)
    assert_equal '1', @object.generate_check_bit(@id_card_3[0...17])
    assert_equal '2', @object.generate_check_bit(@id_card_4[0...17])
  end

  def test_should_generate_addresses_code
    assert_match %r(^\d{4}(?!00)\d{2}$), @object.generate_address_code(nil)
    assert_match %r(^\d{4}(?!00)\d{2}$), @object.generate_address_code('陕西省')
    assert_match %r(^\d{4}(?!00)\d{2}$), @object.generate_address_code('西安市')
    assert_match %r(^\d{4}(?!00)\d{2}$), @object.generate_address_code('碑林区')
    assert_match %r(^\d{4}(?!00)\d{2}$), @object.generate_address_code('未央区')
    assert_match %r(^\d{4}(?!00)\d{2}$), @object.generate_address_code('凤县')
    assert_equal '830000' , @object.generate_address_code('台湾省')
  end

  def test_should_generate_birthday_code
    res_1 = @object.generate_birthday_code(nil)
    res_2 = @object.generate_birthday_code('1993')
    res_3 = @object.generate_birthday_code('199301')
    res_4 = @object.generate_birthday_code('19930101')
    res_5 = @object.generate_birthday_code('1700')

    assert IdValidator::Concern::Func.check_birthday(res_1)
    assert IdValidator::Concern::Func.check_birthday(res_2)
    assert IdValidator::Concern::Func.check_birthday(res_3)
    assert IdValidator::Concern::Func.check_birthday(res_4)
    assert IdValidator::Concern::Func.check_birthday(res_5)

    assert res_2.include?('1993')
    assert res_3.include?('199301')
    assert res_4.include?('19930101')
  end

  def test_should_generate_order_code
    res_1 = @object.generate_order_code(1)
    res_2 = @object.generate_order_code(0)
    res_3 = @object.generate_order_code(nil)

    assert_equal 3, res_1.length
    assert_equal 3, res_2.length
    assert_equal 3, res_3.length
    assert (1..999).include?(res_1.to_i)
    assert (1..999).include?(res_2.to_i)
    assert (1..999).include?(res_3.to_i)
    assert_equal 1, res_1.to_i % 2
    assert_equal 0, res_2.to_i % 2
  end

end
