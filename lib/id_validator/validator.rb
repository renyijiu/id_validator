module IdValidator
  class Validator
    include IdValidator::Concern::Helper

    # 检查身份证合法性
    def is_valid?(id_card)
      code = get_id_argument(id_card)

      return false unless check_address_code(code[:address_code])
      return false unless check_birthday_code(code[:birthday_code])
      return false unless check_order_code(code[:order_code])

      return true if code[:type] == 15

      check_bit = generate_check_bit(code[:body])
      return false if check_bit.nil? || (code[:check_bit] != check_bit)

      true
    end

    # 获取身份证详细信息
    def get_info(id_card)
      return false unless is_valid?(id_card)

      code = get_id_argument(id_card)
      address_info = get_address_info(code[:address_code])

      {
        address_code: code[:address_code],
        address: IdValidator::Concern::Func.format_address_info(address_info),
        abandoned: check_is_abandoned(code[:address_code]),
        birthday_code: IdValidator::Concern::Func.format_birthday_code(code[:birthday_code]),
        constellation: get_constellation(code[:birthday_code]),
        chinese_zodiac: get_chinese_zodiac(code[:birthday_code]),
        sex: code[:order_code].to_i % 2,
        length: code[:type],
        check_bit: code[:check_bit]
      }
    end

    # 构建虚假身份证信息
    def fake_id(eighteen = true, address = nil, birthday = nil, sex = nil)
      address_code = generate_address_code(address)
      birthday_code = generate_birthday_code(birthday)
      order_code = generate_order_code(sex)

      return address_code + birthday_code[2..-1] + order_code unless eighteen

      body = address_code + birthday_code + order_code
      check_bit = generate_check_bit(body)

      body + check_bit
    end

  end
end