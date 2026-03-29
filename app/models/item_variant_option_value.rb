class ItemVariantOptionValue < ApplicationRecord
  belongs_to :item_variant
  belongs_to :item_option_value

  validates :item_option_value_id, uniqueness: { scope: :item_variant_id,
                                                  message: "já está atribuído a esta variante" }

  validate :option_value_belongs_to_same_item

  private

  def option_value_belongs_to_same_item
    return unless item_variant && item_option_value

    variant_item_id      = item_variant.item_id
    option_value_item_id = item_option_value.item_option&.item_id

    unless variant_item_id == option_value_item_id
      errors.add(:item_option_value, "não pertence ao mesmo item que a variante")
    end
  end
end
