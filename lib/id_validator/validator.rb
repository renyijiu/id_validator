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

  end
end