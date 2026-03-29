class ItemVariant < ApplicationRecord
  include MoneyRails::ActiveRecord::Monetizable

  belongs_to :item
  has_many :item_variant_option_values, dependent: :destroy
  has_many :item_option_values, through: :item_variant_option_values

  monetize :price_cents,
           with_currency: :brl,
           allow_nil: false,
           numericality: {
             greater_than: 0,
             message: "deve ser maior que zero"
           }

  validates :stock_quantity,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              message: "não pode ser negativo"
            },
            if: :track_inventory?

  validates :sku,
            uniqueness: { case_sensitive: false, allow_blank: true },
            length:     { maximum: 255, allow_blank: true },
            format:     { with: /\A[a-zA-Z0-9\-_]+\z/, allow_blank: true,
                          message: "aceita apenas letras, números, hífens e underscores" }

  validate :option_values_cover_all_options
  validate :option_combination_is_unique

  private

  def option_values_cover_all_options
    return unless item

    required_option_ids = item.item_options.pluck(:id).sort
    assigned_option_ids = item_option_values.map(&:item_option_id).sort

    if required_option_ids != assigned_option_ids
      errors.add(:item_option_values, "deve incluir exatamente um valor para cada opção do item")
    end
  end

  def option_combination_is_unique
    return unless item

    current_ids = item_option_values.map(&:id).sort
    return if current_ids.empty?

    siblings = item.item_variants.where.not(id: id || 0)

    siblings.each do |sibling|
      sibling_ids = sibling.item_option_values.map(&:id).sort
      if sibling_ids == current_ids
        errors.add(:base, "Já existe uma variante com esta combinação de opções")
        break
      end
    end
  end
end
