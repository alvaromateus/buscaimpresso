class Vendedor < ActiveRecord::Base
  belongs_to :empresa
  has_many :ordem_servico
end
