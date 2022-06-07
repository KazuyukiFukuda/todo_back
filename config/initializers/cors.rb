Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins(['localhost', /localhost:\d+\Z/, /(.+).local.example-dev.com\Z/])
        resource '*',
            headers: :any,
            methods: [:get, :post, :put, :patch, :delete, :options, :head],
            credentials: true
    end
end