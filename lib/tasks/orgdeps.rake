namespace :orgdeps do
  desc "Generate dependencies for all organizations"
  task :deps => :environment do
    Organization.find_each do |organization|
      puts organization
      data = RepoDependencyGraph.send(:dependencies,
        token: organization.github_token,
        organization: organization,
        private: true,
      )
      organization.update_attributes!(repositories: data)
    end
  end
end
