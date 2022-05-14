class OrganizationsController < ApplicationController
  def index
    @organizations = current_user.organizations
  end

  def edit
    organization
  end

  def update
    organization.update!(params.require(:organization).permit(:safe_github_token))
    redirect_to organization_repositories_path(organization)
  end

  private

  def organization
    @organization ||= current_user.organizations.find_by_param!(params.require(:id))
  end
end
