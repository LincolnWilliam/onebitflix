class Movie < ApplicationRecord
  include PgSearch
  # um epsodio que faça parte de uma série ele nao deve ser pesquisado,
  multsearchable against: [:title], if: lambda{ |record| record.serie.nil? }
  belongs_to :serie, optional: true #pode pertencer a uma série mas pode nao pertecer:, belong opcional.
  belongs_to :category, optional: true
  has_many :reviews, as: :reviewable
  has_many :players, dependent: :destroy
  has_one :watched_serie, class_name: "Serie", foreign_key: "last_watched_epsode_id", dependent: :nullify
  validates :title, presence: true
  validates :description, presence: true
  validates :thumbnail_key, presence: true
  validates :video_key, presence: true
  validates :episode_number, presence: true, uniqueness: { scope: :serie_id }, if: ->{ serie.present? }
  validates :category, presence: true, if: ->{serie.nil? } # se ele tiver dentro de uma série nao pode ter uma categoria.
  validates :highlight_episode # chamando metodo para validar.

 

  private
  
           # metodo
    def  highlight_episode
        # se ele fizer parte de uma serie e tiver uma righligth vamos colocar um erro:
        # não é possivel dar righlight em um epsodio da série.
        if self.serie.present? && self.highlighted == true 
         errors.add(:highlight_episode, "It's not possible to highlight an serie episode")
        end
    end
end
