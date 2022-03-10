class Admins::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_administrator!
end