namespace :orgdeps do
  desc "Generate dependencies for all organizations"
  task :deps => :environment do
    Organization.where("github_token IS NOT NULL").find_each do |organization|
      puts organization
      begin
        organization.update_repositories
      rescue StandardError
        puts "Failed #{organization}"
        puts $!
        puts $!.backtrace.join("\n")
      end
    end
  end
end
