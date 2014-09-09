class RepositoriesController < ApplicationController
  skip_before_filter :authenticate!, only: :show

  def index
    organization
  end

  def show
    respond_to do |format|
      format.svg do
        organization = Organization.find_by_param!(params[:organization_id])
        (organization.badge_token == params[:token]) || raise(ActiveRecord::RecordNotFound)
        if stale?(etag: [organization.to_param, params[:id]], last_modified: organization.repositories_updated_at)
          expires_in 1.hour, :public => true
          render(
            text: organization.badge(params[:id]),
            content_type: Mime::SVG
          )
        end
      end
    end
  end

  private

  def organization
    @organization ||= current_user.organizations.find_by_param!(params[:organization_id])
  end
end
