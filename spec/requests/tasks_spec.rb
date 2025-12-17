require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    it "redirects unauthenticated user to the sign-in page" do
      get tasks_index_path
      expect(response).to have_http_status(302)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
  describe "GET /tasks as an authenticated user" do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it "succeeds and renders the index template" do
      get tasks_path

      expect(response).to have_http_status(200)
    end
  end
end
