class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :creation_error
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json:user
    end

    def show 
        user = User.find(session[:user_id])
        if user 
            render json:user 
        else
            render json:{error:'Not logged in'}, status: :unauthorized
        end
    end

    private 

    def user_params 
        params.permit(:username, :password, :password_confirmation)
    end

    def creation_error 
        render json:{errors: user.errors.full_messages}, status: :unprocessable_entity
    end
end
