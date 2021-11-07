class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users, only: [:name, :id]
  end

  # GET /users/1
  def show
    render json: @user, only: [:name]
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    begin
      @user.destroy
    rescue StandardError => e
      render json: e, status: :unprocessable_entity
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_id(params[:id])
    render json: "User Not Found", status: :unprocessable_entity unless @user.present?
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:name)
  end
end
