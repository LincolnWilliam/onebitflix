class Api::V1::DashboardsController < ApplicationController
  
  # end point - index
  # DashboardService- são Classes ruby puras dentro de arquivos chamaods services
  def index
    type_parms and (return if performed?)
    result = DashboardService.new(params[:type], currenti_user).perform # perform - metodo que vai executar
    render json: result
  end

  private

  def type_parms
   params[:type] ||= "category"
   type_whitelist
  end
  # keep_watching - continue assistindo - é pessoal ,nao pode ser mostrado pra outra pessoa,
  def type_whitelist
    unless ["category", "keep_watching", "highlight"].include?(params[:type])
     render json: { errors: "Unpermitted type parameter" }, status: :forbidden
    end
  end 
end