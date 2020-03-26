# frozen_string_literal: true

require "rails_helper"

# TestAPI implements a MethodNotAllowed endpoint.
class TestAPI < Grape::API
  version "v1", using: :path

  get "test" do
    raise Grape::Exceptions::MethodNotAllowed, "method not allowed"
  end
end

# Re-opening ::Api::RootApi to mount the TestAPI endpoints.
class ::Api::RootApi
  mount ::TestAPI
end

describe Api::RootApi, type: :request do
  it "handles unknown routes" do
    get "/api/lala"
    expect(response).to have_http_status(:not_found)
  end

  it "rescues a method not allowed exception" do
    get "/api/v1/test"
    expect(response).to have_http_status(:method_not_allowed)
  end
end
