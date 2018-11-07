class Category < ApplicationRecord
    has_many :series, class_name: "Serie"
    has_many :movies    
    validates :name, presence: true, uniqueness: true
    # presence: tem que estar presente.
    # uniqueness: tem que ser categoria unica, nome nao pode ter duas 
    # categorias com o mesmo nome.
end
