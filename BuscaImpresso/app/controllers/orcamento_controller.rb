class OrcamentoController < ApplicationController
  layout Proc.new { |controller| controller.session[:usuario] ? "empresa" : "usuario_anonimo" }
  def index
    list
    render :action => "list"
  end

  def altera_orcamento
    @orcamento = (params[:orcamento]);
    if (@orcamento == 'CARTAO')
      render :update do |page|
        page[:orcamento_tipo_id].value = "9"
        page[:orcamento_ISS].value = "0"
        page[:orcamento_IPI].value = "0"
        page[:orcamento_ISV].value = "0"
        page[:orcamento_ICMS].value = "0"
        page[:orcamento_lado1].value = "70"
        page[:orcamento_lado2].value = "50"
      end
    end
    if (@orcamento == 'REVISTA')
      render :update do |page|
        page[:orcamento_tipo_id].value = "4"
        page[:orcamento_ISS].value = "0"
        page[:orcamento_IPI].value = "0"
        page[:orcamento_ISV].value = "0"
        page[:orcamento_ICMS].value = "0"
        page[:orcamento_lado1].value = "297"
        page[:orcamento_lado2].value = "260"
      end
    end
    if (@orcamento == 'NOTA')
      render :update do |page|
        page[:orcamento_tipo_id].value = "1"
        page[:orcamento_ISS].value = "0"
        page[:orcamento_IPI].value = "0"
        page[:orcamento_ISV].value = "0"
        page[:orcamento_ICMS].value = "0"
      end
    end
    if (@orcamento == 'JORNAL')
      render :update do |page|
        page[:orcamento_tipo_id].value = "12"
        page[:orcamento_ISS].value = "0"
        page[:orcamento_IPI].value = "0"
        page[:orcamento_ISV].value = "0"
        page[:orcamento_ICMS].value = "0"
      end
    end
    if (@orcamento == 'FOLHETO')
      render :update do |page|
        page[:orcamento_tipo_id].value = "8"
        page[:orcamento_ISS].value = "0"
        page[:orcamento_IPI].value = "0"
        page[:orcamento_ISV].value = "0"
        page[:orcamento_ICMS].value = "0"
      end
    end
  end

  def list
    if session[:orcamento_processos]
      session[:orcamento_processos].clear
    end
    @orcamentos = []
    session[:orcamento].each do |o|
      @orcamentos.push(TipoOrcamento.find(o))
    end
  end

  def adiciona_processo
    @processos = []
    session[:processo].each do |p|
      @processos.push(Processo.find(p))
    end
    render(:partial => "selecao")
  end

  def novo_processo
    unless session[:orcamento_processos]
      session[:orcamento_processos] = []
      session[:orcamento_processos].push(Processo.find(params[:processo]))
      @orcamentos_processo = session[:orcamento_processos]
    else
      session[:orcamento_processos].push(Processo.find(params[:processo]))
      @orcamentos_processo = session[:orcamento_processos]
    end
    render(:partial => "lista")
  end

  def remove_processo
    session[:orcamento_processos].delete(Processo.find(params[:processo]))
    @orcamentos_processo = session[:orcamento_processos]
    render(:partial => "lista")
  end

  def edit
    @tipo_impressos = Tipo.find(:all)
    modo = 0
    if params[:id]
      @orcamento = TipoOrcamento.find(params[:id])
      modo = 1
    else
      @orcamento = TipoOrcamento.new
      modo = 2
    end
    if request.post?
       @orcamento.attributes = params[:orcamento]
       @orcamento.empresa_id = session[:id]
       if @orcamento.save
         if (modo == 2)
           session[:orcamento].push(@orcamento.id)
             if session[:orcamento_processos] #se tiver pprocessos adicionados no orçamento
               session[:orcamento_processos].each do |p|
                 @orcamento_processo = ProcessoTipoOrcamento.new
                 @orcamento_processo.processo_id = p.id
                 @orcamento_processo.tipo_orcamento_id = @orcamento.id
                 @orcamento_processo.save
               end
             end
           end
         redirect_to :action => "index"
         flash[:notice] = "Tipo de Orçamento salvo com sucesso!"
       end
    end
  end

  def delete
    session[:processo].delete(TipoOrcamento.find(params[:id]))
    TipoOrcamento.find(params[:id]).destroy
    flash[:notice] = "O tipo de orçamento foi excluído com sucesso!"
    redirect_to :action => "list"
  end
end