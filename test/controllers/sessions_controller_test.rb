require './test/test_helper'

describe SessionsController do
  describe "#create" do
    it "creates a user" do
      stub_request(:get, "https://api.github.com/user/orgs?access_token=thetoken").to_return(
        status: 200,
        body: JSON.dump([{"login" => "minimum"}]),
        headers: { 'Content-Type' => 'application/json' }
      )

      headers = {
        "omniauth.auth" => {
          "provider" => "github",
          "uid" => "abc",
          "info" => {
            "name" => "A Name",
            "email" => "email@foo.com"
          },
          "credentials" => {
            "token" => "thetoken"
          }
        }
      }

      post "/auth/github/callback", headers: headers

      assert_redirected_to "/"
      user = User.find(session[:user_id])
      user.name.must_equal "A Name"
      user.email.must_equal "email@foo.com"
      user.external_id.must_equal "github-abc"
      user.organizations.map(&:name).must_equal ["minimum"]
    end

    describe "with existing user" do
      let(:headers) do
        provider, uid = users(:minimum).external_id.split("-")
        {"omniauth.auth" => {"provider" => provider, "uid" => uid}}
      end

      it "logs in an existing user" do
        post "/auth/github/callback", headers: headers
        assert_redirected_to "/"
        session[:user_id].must_equal users(:minimum).id
      end

      it "returns to wanted location" do
        described_class.any_instance.stubs(session: {return_to: "/foobar"})
        post "/auth/github/callback", headers: headers
        assert_redirected_to "/foobar"
      end
    end
  end

  describe "#destroy" do
    it "logs the user out" do
      login_as users(:minimum)
      get "/logout"
      refute session[:user_id]
      assert_response :success # cannot redirect since every action will log you in again
    end
  end
end
