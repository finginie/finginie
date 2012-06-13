Rails.application.config.middleware.use NoWWW if Rails.env.production?
