class Api::V1::FavoritesController < ApplicationController
  before_action :set_favorite, only: :destroy # set_favorite rode antes somente de destroy
   # metodos chamados de actions 

   def index  #devolver todos os filmes e series que a gente escolheu
    # (@favorites.map(&:favoritable)) - esta serializando todos os favoritos.
    # map -faz um mapeamento
    #tabela favorite campo favoritable, e mapeia todas as series e videos, com watchableserializer.
    @favorites = current_user.favorites.all                                   
    render json: Api::V1::WatchableSerializer.new(@favorites.map(&:favoritable)).serialized_json
  end

  def create  #criar um novo favorite
    @favorite = Favorite.new(favorite_params.merge(user: current_user)) # .merge(user: current_user)nao deixa favoritar por outra pessoa
    if @favorite.save 
      head :ok
    else
      render json: { errors: @favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end 
  
  def destroy # destruir favorite
    @favorite.destroy
    head :ok
  end
   
  private
  # metodos auxiliares para dar suporte na hora de fazer as ações para evitar repetições.
  def set_favorite # capitalize, retorna com a primeira letra Maiuscula.Ex:'palavra'.capitalize! = Palavra
    # user: current_user - evita que ele apague o favorito de outro usuario pra outra serie qualquer.
    @favorite = Favorite.find_by(favoritable_type: params[:type].capitalize!, favoritable_id: params[:id], user: current_user)
  end 

  def favorite_params
    params.require(:favorite).permit(:favoritable_type, :favoritable_id) 
  end 

end
