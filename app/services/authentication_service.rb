class AuthenticationService
  attr_reader :error

  def initialize(login:, password:)
    @login = login.to_s.strip.downcase
    @password = password
  end

  def call
    user = find_user
    return failure("User not found") unless user
    return failure("Invalid password") unless user.authenticate(@password)

    user
  end

  private

  def find_user
    User.find_by(email: @login) || User.find_by(cellphone: @login)
  end

  def failure(message)
    @error = message
    nil
  end
end
