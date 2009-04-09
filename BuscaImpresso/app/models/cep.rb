require 'net/http'
require 'cgi'

class Cep < ActiveRecord::Base
  validates_presence_of :cep, :message => "- Cep não é um campo opcional"
  validates_format_of :cep, :with => /\d{8}/, :message => "- Cep não está no formato certo"
  has_many :usuarios
  has_many :empresas
end