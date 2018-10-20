require "date"
require "id_validator/version"
require "id_validator/config"
require "id_validator/concern/helper"
require "id_validator/validator"

module IdValidator
  class << self

    # 检查身份证合法性
    def is_valid?(id_card)
      id_card = id_card.to_s
      return false unless [15, 18].include?(id_card.length)

      IdValidator::Validator.new.is_valid?(id_card)
    end

    # 获取身份证详细信息
    def get_info(id_card)
      ::IdValidator::Validator.new.get_info(id_card.to_s)
    end

    # 返回虚假身份证号
    def fake_id(eighteen = true, address = nil, birthday = nil, sex = nil)
      validator = ::IdValidator::Validator.new

      validator.fake_id(eighteen, address, birthday, sex)
    end

    # 身份证号升级（15位 升级为 18位）
    def upgrade_id(id_card)
      ::IdValidator::Validator.new.upgrade_id(id_card.to_s)
    end

  end
end
