class Empresa < ActiveRecord::Base
   belongs_to :ceps
   belongs_to :planos
   belongs_to :parametros
   has_many :tipo_orcamento

   validates_presence_of :nome_fantasia, :message => "- Nome Fantasia não é um campo que opcional"
   validates_presence_of :razao_social, :message => "- Razão Social não é um campo que opcional"
   validates_presence_of :razao_social, :message => "- Razão Social não é um campo que opcional"
   validates_presence_of :plano_id, :message => "- Você nao selecionou o plano desejado"
   validates_format_of :telefone, :with => /^\d{4}-\d{4}$/, :message => "- Formato inválido para o telefone"
end
