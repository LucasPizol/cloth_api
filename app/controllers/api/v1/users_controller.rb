module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :authenticate_user!

      def me
      end
    end
  end
end
