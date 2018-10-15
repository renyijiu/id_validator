module IdValidator
  module Concern
    module Func
      extend self

      # 检测出生日期, example: '20181015'
      def check_birthday(birthday)
        return false if birthday.to_s.length != 8
        date = Date.parse(birthday.to_s) rescue nil

        return false if date.nil?
        return false if date.year < 1800 || date > Date.today

        true
      end

    end

    module Helper
      # 获取身份证信息
      def get_id_argument(id_card)
        id_card = id_card.to_s.upcase

        if id_card.length == 18
          {
              body: id_card[0...17],
              address_code: id_card[0...6],
              birthday_code: id_card[6...14],
              order_code: id_card[14...17],
              check_bit: id_card[17],
              type: 18
          }
        else
          {
              body: id_card,
              address_code: id_card[0...6],
              birthday_code: '19' + id_card[6...12],
              order_code: id_card[12...15],
              check_bit: '',
              type: 15
          }
        end
      end

      # 获取地址信息
      def get_address_info(address_code)
        address_code_hash = IdValidator::Config.address_info
        abandoned_address_code_hash = IdValidator::Config.abandoned_address_code

        province_address_code = "#{address_code[0...2]}0000".to_i
        city_address_code = "#{address_code[0...4]}00".to_i

        province = address_code_hash[province_address_code] || abandoned_address_code_hash[province_address_code]

        if address_code[0].to_i != 8
          city = address_code_hash[city_address_code] || abandoned_address_code_hash[city_address_code]
          district = address_code_hash[address_code.to_i] ||abandoned_address_code_hash[address_code.to_i]
        else
          city = nil
          district = nil
        end

        {
            province: province,
            city: city,
            district: district
        }
      end

      # 检查地址码
      def check_address_code(address_code)
        address_info = get_address_info(address_code.to_s)
        return false if address_info[:province].nil?

        true
      end

      # 检查出生日期
      def check_birthday_code(birthday_code)
        return false unless Func.check_birthday(birthday_code.to_s)

        true
      end

      # 检查顺序码
      def check_order_code(order_code)
        return false if order_code.length != 3

        true
      end

      # 生成校验码
      def generate_check_bit(body)
        body = body.to_s.reverse
        return nil if body.length != 17

        body_sum = 0
        weight = (2..18).map{ |a| 2**(a - 1) % 11 }
        weight.each_with_index{ |w, i| body_sum += body[i].to_i * w }

        check_bit = (12 - (body_sum % 11)) % 11
        check_bit < 10 ? check_bit.to_s : 'X'
      end

    end
  end
end