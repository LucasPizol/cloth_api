Money.rounding_mode = BigDecimal::ROUND_HALF_UP
Money.locale_backend = :i18n

MoneyRails.configure do |config|
  config.default_currency = :brl
  config.include_validations = true
end
