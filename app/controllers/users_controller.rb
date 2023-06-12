class UsersController < ApplicationController
  def new
    @user = User.new
    render template: "users/new"
  end

  def create
    @user = User.new(
      name: params[:user][:name],
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation],
    )
    if @user.save
      @trainer = Trainer.new(
        name: "Default Trainer #{@user.name}",
        title: "Default Title",
        level: 0,
        experience: 0,
        user_id: @user.id,
      )
      @trainer.save

      @user.update(
        current_trainer_id: @trainer.id,
      )
      session[:user_id] = @user.id
      redirect_to "/"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def create
  #   user = User.new(
  #     name: params[:name],
  #     email: params[:email],
  #     password: params[:password],
  #     password_confirmation: params[:password_confirmation],
  #   )
  #   if user.save
  #     render json: { message: "User created successfully" }, status: :created
  #   else
  #     render json: { errors: user.errors.full_messages }, status: :bad_request
  #   end
  # end
end
