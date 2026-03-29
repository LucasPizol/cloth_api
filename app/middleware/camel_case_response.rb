class CamelCaseResponse
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

    if headers["Content-Type"]&.include?("application/json")
      body = +""
      response.each { |chunk| body << chunk }
      parsed = JSON.parse(body)
      camelized = deep_camelize(parsed)
      new_body = JSON.generate(camelized)
      headers["Content-Length"] = new_body.bytesize.to_s
      return [status, headers, [new_body]]
    end

    [status, headers, response]
  end

  private

  def deep_camelize(obj)
    case obj
    when Hash
      obj.transform_keys { |k| camelize(k.to_s) }
         .transform_values { |v| deep_camelize(v) }
    when Array
      obj.map { |v| deep_camelize(v) }
    else
      obj
    end
  end

  def camelize(key)
    parts = key.split("_")
    parts[0] + parts[1..].map(&:capitalize).join
  end
end
