class TrainersController < ApplicationController
  def show
    @trainer = Trainer.find_by(id: params["id"])
    render :show
  end

  def index
    @trainers = Trainer.all
    render :index
  end

  def create
    if current_user
      @trainer = Trainer.new(
        name: params["name"],
        title: params["title"],
        level: params["level"],
        experience: params["experience"],
      )
      @trainer.save
      render :show
    else
      render json: { message: "Not authorized user" }
    end
  end

  def update
    @trainer = Trainer.find_by(id: params["id"])
    @trainer.update(
      name: params["name"] || params.name,
      title: params["title"] || params.title,
      level: params["level"] || params.level,
      experience: params["experience"] || params.experience,
    )
    render :show
  end

  def destroy
    trainer = Trainer.find_by(id: params["id"])
    trainer.destroy
    render json: { message: "Trainer has been deleted" }
  end
end
