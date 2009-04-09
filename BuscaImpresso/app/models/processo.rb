class Processo < ActiveRecord::Base
  validates_presence_of :nome, :message => "- Nome não é um campo opcional"
  validates_presence_of :custo, :message => "- Preço do material não é um campo opcional"
  validates_presence_of :multiplicar, :message => "- É necessário informar a quantidade de vias"
  validates_presence_of :quantidade_paginas, :message => "- É necessário informar a quantidade de páginas"
  validates_presence_of :produtividade, :message => "- É necessário informar a quantidade produzida por hora"
  validates_presence_of :quantidade_acerto, :message => "- É necessário informar o percentual de acerto"


  has_and_belongs_to_many :tipo_orcamento, :join_table =>'processo_tipo_orcamentos'
  belongs_to :maquina
  belongs_to :papel
end
