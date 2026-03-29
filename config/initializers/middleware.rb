require Rails.root.join("app/middleware/camel_case_response")

Rails.application.config.middleware.use CamelCaseResponse
