module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_user, only: [:update, :destroy, :show]
      #全ユーザーを取得するためのアクション
      def index
        @users = User.all
        render json: @users, status: :ok
      end
      #ユーザーの更新を行うためのアクション
      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
      #ユーザーの削除を行うためのアクション
      def destroy
        if @user.destroy
          head :no_content
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
      #特定のユーザーを取得するためのアクション
      def show
        if @user
          render json: @user, status: :ok
        else
          render json: { error: 'User not found' }, status: :not_found
        end
      end

      private
      #ユーザーを取得するためのメソッド
      def set_user
        @user = User.find(params[:id])
      end
      #ユーザーのパラメータを許可するためのメソッド
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, role_ids: [])
      end
    end
  end
end

