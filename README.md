[![Build Status](https://travis-ci.com/renyijiu/id_validator.svg?branch=master)](https://travis-ci.com/renyijiu/id_validator)
[![Gem Version](https://badge.fury.io/rb/id_validator.svg)](https://badge.fury.io/rb/id_validator)
[![Maintainability](https://api.codeclimate.com/v1/badges/c12676a3c0261956e06c/maintainability)](https://codeclimate.com/github/renyijiu/id_validator/maintainability)

# IdValidator

**中华人民共和国居民身份证** 、**中华人民共和国港澳居民居住证** 以及 **中华人民共和国台湾居民居住证** 号码验证工具（Ruby
版）支持 15 位与 18 位号码。

- [JavaScript 版本](https://github.com/mc-zone/IDValidator)
- [PHP 版本](https://github.com/jxlwqq/id-validator)
- [Python 版本](https://github.com/jxlwqq/id-validator.py)

## 安装

将下列代码增加到对应项目的Gemfile中：

```ruby
gem 'id_validator'
```

然后执行下列命令：

    $ bundle

或者，直接安装对应的gem包使用：

    $ gem install id_validator

## 使用

   `440308199901101512` 和 `610104620927690`
   
   示例大陆居民身份证均为随机生成的假数据，如有看雷同，请联系删除。
 
   `810000199408230021` 和 `830000199201300022`
 
   示例港澳台居民居住证为北京市公安局公布的居住证样式号码。
   
### 验证身份证合法性

验证身份证合法性，合法返回 `true`, 不合法返回 `false`

```ruby
IdValidator.is_valid?('440308199901101512') # => true, 大陆居民身份证 18 位
IdValidator.is_valid?('610104620927690')    # => true, 大陆居民身份证 15 位
IdValidator.is_valid?('810000199408230021') # => true, 港澳居民身份证 18 位
IdValidator.is_valid?('830000199201300022') # => true, 台湾居民身份证 18 位
```

### 获取身份证号信息

当身份证号合法时，返回分析信息（地区、出生日期、星座、生肖、性别、校验码），不合法时返回 `false`


```ruby

IdValidator.get_info('440308199901101512') # 大陆居民身份证 18 位
IdValidator.get_info('610104620927690')    # 大陆居民身份证 15 位

```
返回信息格式如下：

```ruby
{
    :address_code => "440308",                   # 地址码
    :address => ["广东省", "深圳市", "盐田区"],      # 地址信息，三元组（省，市，区）
    :abandoned => false,                         # 地址码是否已经废弃
    :birthday_code => "1999-01-10",              # 出生日期
    :constellation => "摩羯座",                   # 星座
    :chinese_zodiac => "卯兔",                    # 生肖 
    :sex => 1,                                   # 性别，0：女性，1：男性
    :length => 18,                               # 号码长度 
    :check_bit=>"2"                              # 校验码
}
```
 
> 注：判断地址码是否废弃的依据是[中华人民共和国行政区划代码历史数据集](https://github.com/jxlwqq/address-code-of-china) ，本数据集的采集源来自：[中华人民共和国民政部](http://www.mca.gov.cn/article/sj/xzqh//1980/) ，每年更新一次。本数据集采用 csv 格式存储，方便大家进行数据分析或者开发其他语言的版本。

### 生成可通过校验的假数据

```ruby
IdValidator.fake_id(eighteen = true, address = nil, birthday = nil, sex = nil)

IdValidator.fake_id                                      # 18位 身份证
IdValidator.fake_id(false)                               # 15位 身份证    
IdValidator.fake_id(true, '上海市')                       # 18位 上海市居民身份证
IdValidator.fake_id(true, '南山区', '1993')               # 18位 出生于 1993年 广东省深圳市南山区身份证
IdValidator.fake_id(true, '江苏省', '199301')             # 18位 出生于 1993年01月 江苏省身份证
IdValidator.fake_id(true, '厦门市', '19930101', 1)        # 18位 出生于 1993年01月01日 福建省厦门市男性身份证
IdValidator.fake_id(true, '台湾省', '20131010', 0)        # 18位 出生于 2013年10月10日 台湾省女性身份证
IdValidator.fake_id(true, '香港特别行政区', '20131010', 0)  # 18位 出生于 2013年10月10日 香港特别行政区女性身份证
```

### 身份证升级

15 位号码升级为 18 位
```ruby
IdValidator.upgrade_id('610104620927690')
=> "610104196209276908"
```
 
## 参考资料

- [中华人民共和国公民身份号码](https://zh.wikipedia.org/wiki/中华人民共和国公民身份号码)

- [中华人民共和国民政部：行政区划代码](http://www.mca.gov.cn/article/sj/xzqh/)

- [中华人民共和国行政区划代码历史数据集](https://github.com/renyijiu/address-code-of-china)

- [国务院办公厅关于印发《港澳台居民居住证申领发放办法》的通知](http://www.gov.cn/zhengce/content/2018-08/19/content_5314865.htm)

- [港澳台居民居住证](https://zh.wikipedia.org/wiki/港澳台居民居住证)

## 如何贡献

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

欢迎贡献相关代码或是提交你的使用反馈👏，另外请记得为你的代码编写测试。