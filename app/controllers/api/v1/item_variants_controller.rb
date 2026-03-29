module Api
  module V1
    class ItemVariantsController < BaseController
      before_action :authenticate_user!
      before_action :set_item
      before_action :set_variant, only: %i[update destroy]

      def create
        @variant = @item.item_variants.build(variant_params)
        if @variant.save
          render :show, status: :created
        else
          render_unprocessable_entity(@variant)
        end
      end

      def update
        if @variant.update(variant_params)
          render :show
        else
          render_unprocessable_entity(@variant)
        end
      end

      def destroy
        @variant.destroy
        head :no_content
      end

      private

      def set_item
        @item = @current_user.shop.items.find(params[:item_id])
      rescue ActiveRecord::RecordNotFound
        render json: { message: "Item não encontrado" }, status: :not_found
      end

      def set_variant
        @variant = @item.item_variants.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { message: "Variante não encontrada" }, status: :not_found
      end

      def variant_params
        params.require(:item_variant).permit(
          :sku, :price_cents, :stock_quantity, :track_inventory,
          item_option_value_ids: []
        )
      end
    end
  end
end
