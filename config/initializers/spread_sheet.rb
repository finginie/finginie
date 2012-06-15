if Rails.env.development? || Rails.env.test?
  ENV['SPREADSHEET_KEY']      ||= "0Ak3raVCu_XPhdGVRX21VZVJpd0owZC1RV1F0R252dlE"
  ENV['SPREADSHEET_LOGIN']    ||= "deploys@finginie.com"
  ENV['SPREADSHEET_PASSWORD'] ||= "gedesh123"
end
