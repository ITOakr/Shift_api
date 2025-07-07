class ShiftsController < ApplicationController
  before_action :authenticate_api_v1_user! # devise-token-authで認証
end
