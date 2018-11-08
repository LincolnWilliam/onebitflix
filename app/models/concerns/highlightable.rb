module Highlightable
  extend ActiveSupport::Concern
  # verifica se tem mais de um filme como capa, highlight(em destaque)
   included do 
     validate :single_highlight
   
     #função que vai verificar se existe outras entidades,sejam elas filmes ou séries highlight
     def single_highlight 
      any_entity = has_any_other_highlighted?(Movie) 
      any_entity ||= has_any_other_highlighted?(Serie) unless any_entity 
       if Highlighted && any_entity
        errors.add(:single_highlight, "Only one highlighted entity is permitted")
       end 
     end
    
     def has_any_other_highlighted?(model)
        records = model.where(highlighted: true)
        if self.class == model
            return records.where.not(id: self.id).any? 
        end
        records.any?
     end
    end
end   