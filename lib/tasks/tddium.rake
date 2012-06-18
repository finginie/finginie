namespace :tddium do
  task :post_build_hook do
    if (ENV['TDDIUM_MODE'] == 'ci') && (ENV['TDDIUM_BUILD_STATUS'] == 'passed')
      dir = File.expand_path("~/.heroku/")
      FileUtils.mkdir_p(dir) or fail "Could not create #{dir}"

      puts "Writing Heroku Credentials"
      File.open(File.join(dir, "credentials"), "w") do |f|
        f.puts ENV['HEROKU_EMAIL']
        f.puts ENV['HEROKU_API_KEY']
      end
      %w(all heroku:addons heroku:config heroku:db:migrate).each do |task|
        Rake::Task[task].invoke
      end

      puts 'for future reference:'
      puts ENV
    end
  end
end
