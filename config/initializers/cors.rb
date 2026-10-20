Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://aasb-2.github.io", "http://127.0.0.1:5500"

    resource "/api/v1/services",
      headers: :any,
      methods: [:get]

    resource "/api/v1/services/*",
      headers: :any,
      methods: [:get]
  end
end