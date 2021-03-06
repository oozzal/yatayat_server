class UsersController < ApplicationController
  http_basic_authenticate_with name: "yatayat", password: "yatayat@nec", only: [:admin_index]

  def admin_index
    @users = User.order("created_at asc").page params[:page]
  end

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
            .to_json(only: [:id, :sim_serial_number, :notify, :username, :role, :phone_number, :email, :first_name, :last_name, :address, :cached_votes_up, :cached_votes_down])

    render json: @user
  end

  # we might return more information like no of posts, frequency etc
  def details
    @user = User.find(params[:id])
            .to_json(only: [:id, :sim_serial_number, :username, :role, :phone_number, :email, :first_name, :last_name, :address, :cached_votes_up, :cached_votes_down])

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

  def update_role
    user = User.find params[:id]
    params = user_params
    if user.update(params)
      redirect_to admin_index_users_path, notice: 'User Updated Successfully.'
    else
      redirect_to admin_index_users_path, notice: 'User Updated Failed.'
    end
  end

  # POST /users/1
  # POST /users/1.json
  def update
    @user = User.find_by_sim_serial_number(params[:id])

    params = user_params
    params.delete_if {|k,v| !params[k].present?}

    if @user.update(params)
      render json: @user
                   .to_json(only: [:id, :sim_serial_number, :username, :role, :phone_number, :email, :first_name, :last_name, :address, :cached_votes_up, :cached_votes_down])
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
    params.require(:user).permit(:username, :phone_number, :sim_serial_number, :device_registration_id, :notify, :email, :first_name, :last_name, :address, :role, :cached_votes_up, :cached_votes_down)
  end
end

