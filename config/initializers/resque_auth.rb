Resque::Server.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ['Finginie', 'Gedesh123']
end
