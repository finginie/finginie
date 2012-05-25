if Rails.env.development? || Rails.env.test?
  ENV['SPREADSHEET_KEY']      ||= "0Ak3raVCu_XPhdG9pM3NIMF95eVZYYlpCcUx1OUQzSHc"
  ENV['SPREADSHEET_LOGIN']    ||= "deploys@finginie.com"
  ENV['SPREADSHEET_PASSWORD'] ||= "gedesh123"
end
