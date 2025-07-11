module Api
  module V1
    class RoleUsersController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_role_user, only: [:destroy]
      before_action :set_user, only: [:index]

      # GET /api/v1/users/:user_id/roles
      def index
        @roles = @user.roles
        render json: @roles
      end

      # POST /api/v1/role_users
      # Params: { user_id: 1, role_id: 2 }
      def create
        @role_user = RoleUser.new(role_user_params)
        if @role_user.save
          render json: @role_user, status: :created
        else
          render json: @role_user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/role_users/:id
      def destroy
        if @role_user.destroy
          head :no_content
        else
          render json: @role_user.errors, status: :unprocessable_entity
        end
      end

      private

      def set_role_user
        @role_user = RoleUser.find(params[:id])
      end

      def set_user
        @user = User.find(params[:user_id])
      end

      def role_user_params
        params.require(:role_user).permit(:user_id, :role_id)
      end
    end
  end
end

