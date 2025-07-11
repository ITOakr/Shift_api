module Api
  module V1
    class ShiftsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_user, only: %i[create]
      before_action :set_shift, only: %i[update destroy]

      # GET /api/v1/users/:user_id/shifts
      # def index
      #   @shifts = @user.shifts
      #   render json: @shifts, status: :ok
      # end
      # GET /api/v1//shifts
      def index
        @shifts = Shift.all
        render json: @shifts, status: :ok
      end

      # POST /api/v1/users/:user_id/shifts
      def create
        @shift = @user.shifts.build(shift_params)
        if @shift.save
          render json: @shift, status: :created
        else
          render json: @shift.errors, status: :unprocessable_entity
        end
      end

      # GET /api/v1/shifts/:id
      # def show
      #   render json: @shift, status: :ok
      # end
      def show
        @shifts = current_api_v1_user.shifts
        render json: @shifts, status: :ok
      end
      
      # GET /api/v1/shifts/:id
      def show_specific
        @shift = current_api_v1_user.shifts.find(params[:id])
        render json: @shift, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Shift not found' }, status: :not_found
      end

      # PATCH/PUT /api/v1/shifts/:id
      def update
        if @shift.update(shift_params)
          render json: @shift, status: :ok
        else
          render json: @shift.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/shifts/:id
      def destroy
        if @shift.destroy
          head :no_content
        else
          render json: @shift.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_shift
        @shift = Shift.find(params[:id])
      end

      def shift_params
        params.require(:shift).permit(:start_time, :end_time, :status, :note)
      end
    end
  end
end
