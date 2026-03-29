module Api
  module V1
    class ItemsController < BaseController
      before_action :authenticate_user!
      before_action :set_item, only: %i[show update destroy]

      def index
        @items = current_shop.items
                             .includes(:item_options, :item_variants)
                             .order(created_at: :desc)
      end

      def show; end

      def create
        @item = current_shop.items.build(item_params)
        if @item.save
          render :show, status: :created
        else
          render_unprocessable_entity(@item)
        end
      end

      def update
        if @item.update(item_params)
          render :show
        else
          render_unprocessable_entity(@item)
        end
      end

      def destroy
        @item.destroy
        head :no_content
      end

      private

      def set_item
        @item = current_shop.items
                            .includes(item_options: :item_option_values, item_variants: :item_option_values)
                            .find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { message: "Item não encontrado" }, status: :not_found
      end

      def current_shop
        @current_user.shop
      end

      def item_params
        params.require(:item).permit(
          :name, :description, :status,
          item_options_attributes: [
            :id, :name, :position, :_destroy,
            item_option_values_attributes: [
              :id, :value, :position, :_destroy
            ]
          ]
        )
      end
    end
  end
end
