class RepositoriesController < ApplicationController
  skip_before_action :authenticate!, only: :show

  def index
    @organization = current_user.organizations.find_by_param!(params[:organization_id])
    respond_to do |format|
      format.html
      format.json do
        render json: @organization.repositories
      end
    end
  end

  def show
    respond_to do |format|
      format.svg do
        organization = Organization.find_by_param!(params[:organization_id])
        Rack::Utils.secure_compare(organization.badge_token, params[:token]) || raise(ActiveRecord::RecordNotFound)

        if stale?(etag: [organization.to_param, params[:id]], last_modified: organization.repositories_updated_at)
          expires_in 1.hour, public: true
          redirect_to organization.badge_url(params[:id])
        end
      end
    end
  end
end
