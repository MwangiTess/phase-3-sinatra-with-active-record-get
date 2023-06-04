class ApplicationController < Sinatra::Base
set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    # return a JSON response with an array of all the game data
    # to_json is an active record method that converts a list of acive record objects to a json formatt
   
   # games = Game.all =>get all the games from the database
   # games = Game.all.order(:title) => get all the games but sorted using titles
    
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  #returns a specific game id with its reviews and users

  # get '/games/:id' do
  #   game = Game.find(params[:id])
  #  # game.to_json(include: :reviews)
  #  game.to_json(include: { reviews: { include: :user }})
  # end


  # We can also be more selective about which attributes are returned from each model with the only option:


  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end
end