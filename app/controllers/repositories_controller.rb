class RepositoriesController < ApplicationController
  def index
    @repositories = organization.repositories
  end

  def show
    render :text => "A REPOS"
  end

  private

  def organization
    @organization ||= Organization.find_by_param!(params[:organization_id])
  end
end
