class OrganizationsController < ApplicationController
  def index
    render :text => "ORGS #{current_user.organizations.map(&:id)}"
  end
end
