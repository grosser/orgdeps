class RepositoriesController < ApplicationController
  def index
    render :text => "ALL REPOS FROM #{organization.name}"
  end

  def show
    render :text => "A REPOS"
  end

  private

  def organization
    Organization.find(params[:organization_id])
  end
end
