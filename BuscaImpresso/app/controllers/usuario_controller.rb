require 'net/http'
require 'cgi'
require 'uri'
class UsuarioController < ApplicationController
  layout Proc.new { |controller| controller.session[:usuario] ? "usuario" : "usuario_anonimo" }

  def index
    list
    render :action => "list"
  end

  def list
  	@usuarios = Usuario.find :all, :order => "nome"
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
    if params[:id]
      @usuario = Usuario.find(params[:id])
      @cep = Cep.find(@usuario.cep_id)
    else
      @usuario = Usuario.new
      @cep = Cep.new
    end
    if request.post?
      if @usuario.cep_id # se tiver já houver endereço
        @cep.attributes = params[:form_cep]
        @usuario.attributes = params[:usuario]
        if @usuario.save && @cep.save
          flash[:notice] = "O usuário foi salvo com sucesso!"
          redirect_to :controller => 'home', :action => "index"
        end
      end
      if @usuario.cep_id == nil # se não houver endereço
         @cep = Cep.create(params[:form_cep])
         @usuario.cep_id = @cep.id
  			 @usuario.attributes = params[:usuario]
  			 if @usuario.save
           session[:permissao] = 1
           session[:usuario] = @usuario.nome
           session[:id] = @usuario.id
           redirect_to :controller => 'home', :action => "index"
  		   end
      end
    end
  end

  def delete
  	Usuario.find(params[:id]).destroy
  	flash[:notice] = "O usuário foi excluído com sucesso!"
  	redirect_to :action => "list"
  end
end