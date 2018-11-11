class Api::V1::ExecutionsController < ApplicationController
  before_action :set_execution, only: :update
  #skip_before_action :verify_authenticity_token
  
  # quando se roda o 'rails g controller' ele cria por padrao os def's- show e update
  # vamos usar o show, as rotas já estão corretas 
  
  # find_or_create_by-  Se eu não encontro o player eu crio.
  # se tiver que criar end_data como nil. esse cara nao terminou de ver o fillme
  def show
    movie = Movie.find(params[:id])
    @player = movie.players.find_or_create_by(end_date: nil, user: current_user)
    render json: Api::V1::playerSerializer.new(@player, include: [:movie]).serialized_json

  end

  def update
    if @player.update(player_params.merge(user: current_user))
      render json: Api::V1::playerSerializer.new(@player, include: [:movie]).serialized_json
    else
      render json: { errors: @player.errors.full_message }, stauts: :unprocessable_entity
    end
  end

  private

  def player_params
    params.require(:execution).permit(:elapsed_time, :end_date)
  end
  # find - encontra pelo id do proprio records
  # find_by encontra por um campo dentro da tabela, no caso aqui-tabela movie_id                    
  # todo player tem um movie_id.
  def set_execution 
    @player = Player.find_by(movie_id: params[:id])
  end

end
