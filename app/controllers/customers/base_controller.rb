class Customers::BaseController < ApplicationController::Base
  before_action :authenticate_customer!
end