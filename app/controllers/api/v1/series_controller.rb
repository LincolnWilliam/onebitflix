class Api::V1::SeriesController < ApplicationController
  def show
    @serie = Serie.find(params[:id])
    render json: Api::A1::SerieSerializer.new(@serie, include:[:epsodes], params: { user: current_user }).serialized_json
  end
end
