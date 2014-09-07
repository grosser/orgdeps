require './test/test_helper'

describe OrganizationsController do
  before do
    login_as users(:minimum)
  end

  describe "#index" do
    it "renders" do
      get :index
      assert_response :success
    end
  end
end
