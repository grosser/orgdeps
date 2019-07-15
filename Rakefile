# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Run brakeman ... use brakewan -I to add new ignores'
task :brakeman do
  sh "brakeman --ensure-latest --exit-on-err --exit-on-warn --format plain --run-all-checks"
end

desc "Audit gems for vulernabilities"
task :audit do
  # CVE-2015-9284 <-> https://github.com/omniauth/omniauth/pull/809
  # this app is not affected since it only uses 1 provider
  sh "bundle-audit update && bundle audit check --ignore CVE-2015-9284"
end

desc "Run all tests"
task :ci do
  tasks = File.readlines('.travis.yml').map { |l| l[/TASK='(.+)'/, 1] }.compact
  tasks.each { |t| sh "rake #{t}" }
end
