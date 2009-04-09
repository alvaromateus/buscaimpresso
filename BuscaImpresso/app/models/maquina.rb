class Maquina < ActiveRecord::Base
  has_many :processo
  validates_presence_of :descricao, :message => "- Descrição não é um campo opcional"
  validates_presence_of :largura_maxima1, :message => "- Largura maxima 1 não é um campo opcional"
  validates_presence_of :largura_minima1, :message => "- Largura mínima 1 não é um campo opcional"
  validates_presence_of :largura_maxima2, :message => "- Largura máxima 2 não é um campo opcional"
  validates_presence_of :largura_minima2, :message => "- Largura mínima 2 não é um campo opcional"
  validates_presence_of :quebra1000, :message => "- É necessário informar percentual de quebra até 1000 exemplares"
  validates_presence_of :quebra5000, :message => "- É necessário informar percentual de quebra até 5000 exemplares"
  validates_presence_of :quebra_5000, :message => "- É necessário informar percentual de quebra para mais de 5000 exemplares"
  validates_presence_of :custo, :message => "- Custo hora/maquina não é um campo opcional"
end
