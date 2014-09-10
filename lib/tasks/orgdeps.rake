namespace :orgdeps do
  desc "Generate dependencies for all organizations"
  task :deps => :environment do
    success = true
    Organization.where("github_token IS NOT NULL").find_each do |organization|
      puts organization
      begin
        organization.update_repositories
      rescue StandardError
        success = false
        puts "Failed #{organization}"
        puts $!
        puts $!.backtrace.join("\n")
      end
    end
    abort unless success # let monitoring know
  end
end
