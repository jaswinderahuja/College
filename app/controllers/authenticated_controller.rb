class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery
end
