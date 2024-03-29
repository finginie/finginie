if Rails.env.development? || Rails.env.test?
  # note: seperate spread sheet is used  development and test.
  ENV['SPREADSHEET_KEY']      ||= "0Ak3raVCu_XPhdGVRX21VZVJpd0owZC1RV1F0R252dlE"
  ENV['SPREADSHEET_LOGIN']    ||= "deploys@finginie.com"
  ENV['SPREADSHEET_PASSWORD'] ||= "gedesh123"
end

SPREADSHEET = SheetMapper::Spreadsheet.new(
    :key      => ENV['SPREADSHEET_KEY'],
    :login    => ENV['SPREADSHEET_LOGIN'],
    :password => ENV['SPREADSHEET_PASSWORD']
)
