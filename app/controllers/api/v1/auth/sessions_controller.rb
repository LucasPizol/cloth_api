module Api
  module V1
    module Auth
      class SessionsController < Api::V1::BaseController
        def create
          service = AuthenticationService.new(
            login: login_params[:login],
            password: login_params[:password]
          )

          user = service.call

          unless user
            return render_unauthorized(service.error || "Invalid credentials")
          end

          cookies.signed[:auth_token] = {
            value: JwtService.encode({ user_id: user.id }),
            httponly: true,
            same_site: :strict,
            expires: 24.hours.from_now
          }

          @current_user = user
        end

        private

        def login_params
          params.require(:session).permit(:login, :password)
        end
      end
    end
  end
end
