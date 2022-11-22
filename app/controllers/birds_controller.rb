class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end
 
  def update 
    # find the bird
    new_bird = Bird.find_by(id: params[:id])

    # found /birds
    if new_bird
      new_bird.update(bird_params)
      render json: new_bird, status: :accepted
      
    else
      render json: {error: "Bird not found"}, status: :not_found
    end

  end

  def increment_likes
    # find
    bird_like = Bird.find_by(id: params[:id])

    if bird_like
      bird_like.update(likes: bird_like.likes + 1)
      render json: bird_like

      # not found
    else
      render json: {error: "Bird not found"}, status: :not_found
    end
  end

  private

  def bird_params
    params.permit(:name, :species)
  end

end
