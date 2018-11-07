class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user
  validates :rating, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }   
  validates :description, presence: true, lenght: { minimum: 50 } 
  validates :user_id, uniqueness: { scope: [:reviewable_type, :reviewable_id],message:"can add only one review per resource" } 
end
#validações:
# rating: nota de 0 a 5 , presence: presença obrigatoria , 
# numericality: only_integer: true - só aceita numeros inteiros .
# greater_than: 0 - numero tem q ser maior que 0
# less_than_or_equal_to: 5 } - e menor que 5.
# validação descrição: presence: true, -tem que estar presente.
#lenght: { minimum: 50 } - tem que ter no maximo 50 caracteres.

# validates :user_id, uniqueness: { scope: [:reviewable_type, :reviewable_id],
# - usuário não pode ter dois reviews no mesmo filme ou na 
# mesma serie, se acondição for quebrada. pode colocar a mensagem: