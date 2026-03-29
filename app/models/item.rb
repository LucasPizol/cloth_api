class Item < ApplicationRecord
  STATUSES = %w[draft active archived].freeze
  MAX_OPTIONS = 3

  belongs_to :shop
  has_many :item_options,  dependent: :destroy
  has_many :item_variants, dependent: :destroy
  has_many :item_option_values, through: :item_options

  accepts_nested_attributes_for :item_options,
    allow_destroy: true,
    reject_if: :all_blank

  validates :name,   presence: true, length: { maximum: 255 }
  validates :status, presence: true, inclusion: { in: STATUSES }

  validate :option_count_within_limit

  scope :active,   -> { where(status: "active") }
  scope :archived, -> { where(status: "archived") }
  scope :draft,    -> { where(status: "draft") }

  private

  def option_count_within_limit
    count = item_options.reject(&:marked_for_destruction?).size
    if count > MAX_OPTIONS
      errors.add(:item_options, "não pode exceder #{MAX_OPTIONS} tipos de opção (ex: Cor, Tamanho, Material)")
    end
  end
end
