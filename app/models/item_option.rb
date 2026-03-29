class ItemOption < ApplicationRecord
  belongs_to :item
  has_many :item_option_values, dependent: :destroy

  accepts_nested_attributes_for :item_option_values,
    allow_destroy: true,
    reject_if: :all_blank

  validates :name,     presence: true, length: { maximum: 100 }
  validates :position, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :name,     uniqueness: { scope: :item_id, case_sensitive: false,
                                     message: "já existe para este item" }

  default_scope -> { order(:position) }

  before_validation :set_default_position, on: :create
  before_destroy :prevent_destroy_if_variants_exist

  private

  def set_default_position
    self.position ||= (item&.item_options&.maximum(:position).to_i + 1)
  end

  def prevent_destroy_if_variants_exist
    if item_option_values.joins(:item_variant_option_values).exists?
      errors.add(:base, "Não é possível excluir uma opção que está em uso por variantes")
      throw :abort
    end
  end
end
