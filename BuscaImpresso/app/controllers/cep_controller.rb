class CepController < ApplicationController
  def index
    list
    render :action => "list"
  end

  def list
    @ceps = Cep.find :all, :order => "logradouro"
  end

  def edit
    if params[:id]
      @cep = Cep.find(params[:id])
    else
      @cep = Cep.new
    end
    if request.post?
      @cep.attributes = params[:cep]
      if @cep.save
        flash[:notice] = "O endereço foi salvo com sucesso!"
        redirect_to :action => "list"
      end
    end
  end

  def delete
    Cep.find(params[:id]).destroy
    flash[:notice] = "O endereço foi excluído com sucesso!"
    redirect_to :action => "list"
  end
end