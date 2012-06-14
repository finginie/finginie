namespace :tddium do
  task :post_build_hook => [:all, :migrate]
end
