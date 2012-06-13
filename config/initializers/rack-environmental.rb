Rails.application.config.middleware.use Rack::Environmental,
                                        :staging => {
                                          :url => /^finginie.herokuapp.+$/,
                                          :color => 'yellow'
                                        },
                                        :test => {
                                          :url => /^test.+$/,
                                          :color => 'purple'
                                        },
                                        :development => {
                                          :url => /^localhost.+$/,
                                          :color => 'orange'
                                        }
