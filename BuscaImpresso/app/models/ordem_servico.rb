class OrdemServico < ActiveRecord::Base
  belongs_to :vendedor
  belongs_to :usuario
  belongs_to :tipo_orcamento
end
