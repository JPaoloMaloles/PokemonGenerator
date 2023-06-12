class TrainersController < ApplicationController
  before_action :authenticate_user

  def show
    @trainer = Trainer.find_by(id: params["id"])
    render :show
  end

  def index
    @trainers = Trainer.all
    render :index
  end

  def new
    @trainer = Trainer.new
    render :new
  end

  def create
    @trainer = Trainer.new(
      name: params[:trainer][:name],
      title: params[:trainer][:title],
      level: 0,
      experience: 0,
      user_id: current_user.id,
    )
    @trainer.save
    redirect_to "/trainers/#{@trainer.id}"
  end

  def edit
    @trainer = Trainer.find_by(id: params[:id])
    render :edit
  end

  def update
    @trainer = Trainer.find_by(id: params["id"])
    @trainer.update(
      name: params[:trainer][:name],
      title: params[:trainer][:title],
    )
    redirect_to "/trainers/#{@trainer.id}"
  end

  def destroy
    trainer = Trainer.find_by(id: params["id"])
    trainer.destroy
    render json: { message: "Trainer has been deleted" }
  end
end
