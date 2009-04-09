class ProcessoController < ApplicationController
  layout Proc.new { |controller| controller.session[:usuario] ? "empresa" : "usuario_anonimo" }
  def index
    list
    render :action => "list"
  end

  def altera_processo
    @processo = (params[:processo]);
    if (@processo == 'IMPRESSAO')
      render :update do |page|
        page[:processo_nome].value = "IMPRESSÃO"
        page[:processo_tercerizado].checked = false
        page[:processo_descricao_material].value = "PAPEL"
        page[:processo_custo].value = "0"
        page[:processo_multiplicar].value = "1"
        page[:processo_produtividade].value = "1"
        page[:processo_quantidade_acerto].value = "1"
        page[:processo_quantidade_paginas].value = "1"
      end
    end
    if (@processo == 'FOTOLITO')
      render :update do |page|
        page[:processo_nome].value = "FOTOLITO"
        page[:processo_tercerizado].checked = false
        page[:processo_descricao_material].value = "PAPEL"
        page[:processo_custo].value = "0"
        page[:processo_multiplicar].value = "1"
        page[:processo_produtividade].value = "1"
        page[:processo_quantidade_acerto].value = "1"
        page[:processo_quantidade_paginas].value = "1"
      end
    end
    if (@processo == 'CHAPAS')
      render :update do |page|
        page[:processo_nome].value = "CHAPAS"
        page[:processo_tercerizado].checked = false
        page[:processo_descricao_material].value = "PAPEL"
        page[:processo_custo].value = "0"
        page[:processo_multiplicar].value = "1"
        page[:processo_produtividade].value = "1"
        page[:processo_quantidade_acerto].value = "1"
        page[:processo_quantidade_paginas].value = "1"
      end
    end
    if (@processo == 'REFILE')
      render :update do |page|
        page[:processo_nome].value = "REFILE"
        page[:processo_tercerizado].checked = true
        page[:processo_descricao_material].value = "PAPEL"
        page[:processo_custo].value = "0"
        page[:processo_multiplicar].value = "1"
        page[:processo_produtividade].value = "1"
        page[:processo_quantidade_acerto].value = "1"
        page[:processo_quantidade_paginas].value = "1"
      end
    end
    if (@processo == 'PICOTAR')
      render :update do |page|
        page[:processo_nome].value = "PICOTAR"
        page[:processo_tercerizado].checked = false
        page[:processo_descricao_material].value = "PAPEL"
        page[:processo_custo].value = "0"
        page[:processo_multiplicar].value = "1"
        page[:processo_produtividade].value = "1"
        page[:processo_quantidade_acerto].value = "1"
        page[:processo_quantidade_paginas].value = "1"
      end
    end
    if (@processo == 'ARTE')
      render :update do |page|
        page[:processo_nome].value = "ARTE"
        page[:processo_tercerizado].checked = false
        page[:processo_descricao_material].value = "MÃO-DE-OBRA"
        page[:processo_custo].value = "35"
        page[:processo_multiplicar].value = "1"
        page[:processo_produtividade].value = "1"
        page[:processo_quantidade_acerto].value = "1"
        page[:processo_quantidade_paginas].value = "1"
      end
    end
  end

  def edit
   @maquinas = []
   if session[:maquina]
     session[:maquina].each do |m|
       @maquinas.push(Maquina.find(m))
     end
   end
   @papeis = []
   if session[:papel]
    session[:papel].each do |p|
      @papeis.push(Papel.find(p))
    end
   end
   modo = 0
   if params[:id]
     @processo = Processo.find(params[:id])
     modo = 1
   else
     @processo = Processo.new
     modo = 2
   end
   if request.post?
      @processo.attributes = params[:processo]
      if @processo.save
        if (modo == 2) # se estiver em modo de inserção
          session[:processo].push(@processo.id) #adicional a mais uma instancia
        end
        redirect_to :action => "index"
        flash[:notice] = "Processo salvo com sucesso!"
      end
   end
  end

  def list
    @processos = []
    session[:processo].each do |p|
      @processos.push(Processo.find(p))
    end
  end

  def delete
    session[:processo].delete(Processo.find(params[:id]))
    Processo.find(params[:id]).destroy
    flash[:notice] = "O Processo foi excluído com sucesso!"
    redirect_to :action => "list"
  end
end