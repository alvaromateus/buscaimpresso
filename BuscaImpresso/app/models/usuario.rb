class Usuario < ActiveRecord::Base
   belongs_to :ceps

   validates_presence_of :nome, :message => "- Nome não é um campo que opcional"
   validates_presence_of :login, :message => "- Login não é um campo que opcional"
   validates_presence_of :senha, :message => "- Senha não é um campo que opcional"
   validates_presence_of :fone, :message => "- Telefone não é um campo que opcional"

end