class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_sim_serial_number(params[:id])
            .to_json(only: [:id, :sim_serial_number, :username, :phone_number, :email, :first_name, :last_name, :address, :cached_votes_up, :cached_votes_down])

    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users/1
  # POST /users/1.json
  def update
    @user = User.find_by_sim_serial_number(params[:id])

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find_by_sim_serial_number(params[:id])
    @user.destroy

    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:username, :phone_number, :sim_serial_number, :email, :first_name, :last_name, :address, :cached_votes_up, :cached_votes_down)
  end
end

