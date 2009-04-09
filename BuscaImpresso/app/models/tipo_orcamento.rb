class TipoOrcamento < ActiveRecord::Base
  has_and_belongs_to_many :processo, :join_table =>'processo_tipo_orcamentos'
  belongs_to :empresa
  belongs_to :tipo

  validates_presence_of :descricao, :message => "- Descrição não é um campo que opcional"
  validates_presence_of :ISS, :message => "- ISS não é um campo que opcional"
  validates_presence_of :IPI, :message => "- IPI não é um campo que opcional"
  validates_presence_of :ISV, :message => "- ISV não é um campo que opcional"
  validates_presence_of :ICMS, :message => "- ICMS não é um campo que opcional"
  validates_presence_of :lado1, :message => "- Largura não é um campo que opcional"
  validates_presence_of :lado2, :message => "- Altura não é um campo que opcional"
  validates_presence_of :tipo_id, :message => "- É necessário selecionar um tipo de orçamento"
end
