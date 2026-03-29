class JwtService
  ALGORITHM = "HS256"
  EXPIRATION = 24.hours

  class DecodeError < StandardError; end
  class ExpiredTokenError < DecodeError; end

  def self.encode(payload)
    payload = payload.merge(
      exp: EXPIRATION.from_now.to_i,
      iat: Time.current.to_i
    )
    JWT.encode(payload, secret_key, ALGORITHM)
  end

  def self.decode(token)
    decoded = JWT.decode(token, secret_key, true, { algorithm: ALGORITHM })
    HashWithIndifferentAccess.new(decoded.first)
  rescue JWT::ExpiredSignature
    raise ExpiredTokenError, "Token has expired"
  rescue JWT::DecodeError => e
    raise DecodeError, e.message
  end

  def self.secret_key
    Rails.application.credentials.secret_key_base
  end
  private_class_method :secret_key
end
