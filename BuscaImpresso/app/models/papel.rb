class Papel < ActiveRecord::Base
  validates_presence_of :descricao, :message => "- Descrição não é um campo que opcional"
  validates_presence_of :lado1, :message => "- Largura não é um campo que opcional"
  validates_presence_of :lado2, :message => "- Altura não é um campo que opcional"
  validates_presence_of :gramatura, :message => "- Gramatura não é um campo que opcional"
  validates_presence_of :abs_tinta, :message => "- É necessário selecionar o grau de absorção de tinta"

  has_many :processo
end