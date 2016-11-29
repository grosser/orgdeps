# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc 'Run brakeman ... use brakewan -I to add new ignores'
task :brakeman do
  sh "BRAKECHECK_GEM=brakeman bundle exec brakecheck" # see https://github.com/presidentbeef/brakeman/issues/968
  sh "brakeman --exit-on-warn --format plain --run-all-checks"
end

desc "Audit gems for vulernabilities"
task :audit do
  sh "bundle-audit update && bundle-audit"
end

desc "Run all tests"
task :ci do
  tasks = File.readlines('.travis.yml').map { |l| l[/TASK='(.+)'/, 1] }.compact
  tasks.each { |t| sh "rake #{t}" }
end
