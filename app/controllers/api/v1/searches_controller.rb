class Api::V1::SearchesController < ApplicationController
  
  def index # obg: Rails não se executa 2 renders ao mesmo tempo.
    check_search_value and (return if performed?) # performed verificar se 1 render foi executado, se foi execultado da retorn. nesse caso, nao continuar a executar o programa.
    search = PgSearch.multisearch(params[:value]).order("created_at DESC")
    render json:
    Api::V1:watchableSerializer.new(search.map(&:searchable)).serialized_json 
  end
   
  private

     def check_search_value
        if params[:value].present? && params[:value].length < 3 
          render json: { errors: "Parameter :value must have at least 3 characters" } 
        end 
     end
end
