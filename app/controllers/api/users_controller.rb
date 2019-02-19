# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :set_user

  def update
    @user.slug = nil
    if @user.update(update_params)
      # Create a ship a new authorization token.
      auth_token = ApiAuth.encode(user: @user.id,
                                  email: @user.email,
                                  name: @user.name,
                                  slug: @user.slug,
                                  admin: @user.admin?)
      render json: {auth_token: auth_token}
    else
      render json: {errors: @user.errors.full_messages}, status: :not_acceptable
    end
  end

  def destroy
    @user.destroy
    head :ok
  end

private

  def set_user
    @user = User.friendly.find(params[:id])

    # Affirm that the request user matches the JWT authenticated user. This is
    # needed to prevent bad actors spoofing other users.
    head :bad_request if @user != current_user
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def update_params
    params.require(:user).permit(:name, :password)
  end
end