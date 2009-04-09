class OrdemServicoController < ApplicationController
  layout "vendedor"
  def index
    list_suas
    render :action => "list_suas"
  end

  def list_pendentes
    @os_pendentes = OrdemServico.find_by_sql("select * from ordem_servicos where vendedor_id is null")
  end

  def info_cliente
    @cliente = Usuario.find(params[:cliente_id])
  end

  def list_suas
    @suas_os = OrdemServico.find_by_sql("select * from ordem_servicos where vendedor_id =" + session[:id].to_s)
  end

  def associa
    ordem = OrdemServico.find(params[:os_id])
    ordem.vendedor_id = params[:vendedor_id]
    ordem.save
    redirect_to :action => "index"
  end
end
