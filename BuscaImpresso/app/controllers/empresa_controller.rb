require 'net/http'
require 'cgi'
require 'uri'
class EmpresaController < ApplicationController

  layout Proc.new { |controller| controller.session[:usuario] ? "empresa" : "usuario_anonimo" }

  def index
    list
    render :action => "list"
  end

  def list
    @empresas = Empresa.find :all, :order => "razao_social"
  end

  def busca_cep
    @c = (params[:cep]);
    consulta = Net::HTTP::Proxy("55.16.10.27",8080).get_response(URI.parse("http://cep.republicavirtual.com.br/web_cep.php?cep=#{@c}&formato=query_string"));

    pesquisa = CGI::parse(consulta.body)
    pesquisa = Hash[*pesquisa.map { |k, v| [k, v[0]] }.flatten]

    render :update do |page|
    #  lancando valores de teste
      page[:form_cep_logradouro].value = pesquisa['logradouro']

    end
  end

  def edit
    @planos = Plano.find(:all)
    if params[:id]
      @empresa = Empresa.find(params[:id])
      @cep = Cep.find(@empresa.cep_id)
    else
      @empresa = Empresa.new
      @cep = Cep.new
      @parametro = Parametro.new
    end
    if request.post?
      if @empresa.cep_id && @empresa.parametro_id # se tiver já houver endereço e parametro
        @cep.attributes = params[:form_cep]
        @empresa.attributes = params[:empresa]
        if @empresa.save && @cep.save
          session[:permissao] = 2 # permissão de empresa
          session[:usuario] = @empresa.razao_social
          session[:id] = @empresa.id
          session[:parametro] = @empresa.parametro_id
          render :partial => "empresa_aviso", :layout => "empresa"
        end
      end
      if @empresa.cep_id == nil && @empresa.parametro_id == nil # se não houver endereço nem parâmetro
         @cep = Cep.create(params[:form_cep])
         @parametro = Parametro.create
         @empresa.cep_id = @cep.id
         @empresa.parametro_id = @parametro.id
         @empresa.attributes = params[:empresa]
         if @empresa.save
           session[:permissao] = 2 # permissão de empresa
           session[:usuario] = @empresa.razao_social
           session[:id] = @empresa.id
           session[:parametro] = @parametro.id

           session[:maquina] = []
           session[:papel] = []
           session[:papeis] = []
           session[:orcamento_processos] = []
           session[:processo] = []
           session[:orcamento] =[]
           session[:vendedores] =[]
           render :partial => "empresa_aviso", :layout => "empresa"
         end
      end
    end
  end

  def delete
    Empresa.find(params[:id]).destroy
    flash[:notice] = "A empresa foi excluído com sucesso!"
    redirect_to :action => "list"
  end
end