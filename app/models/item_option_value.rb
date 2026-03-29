class ItemOptionValue < ApplicationRecord
  belongs_to :item_option
  has_many :item_variant_option_values, dependent: :destroy
  has_many :item_variants, through: :item_variant_option_values

  validates :value,    presence: true, length: { maximum: 100 }
  validates :position, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :value,    uniqueness: { scope: :item_option_id, case_sensitive: false,
                                     message: "já existe para esta opção" }

  default_scope -> { order(:position) }

  before_validation :set_default_position, on: :create

  private

  def set_default_position
    self.position ||= (item_option&.item_option_values&.maximum(:position).to_i + 1)
  end
end
