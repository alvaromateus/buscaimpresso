class MaquinaController < ApplicationController

  layout Proc.new { |controller| controller.session[:usuario] ? "empresa" : "usuario_anonimo" }
  def index
    list
    render :action => "list"
  end

  def list
    @maquinas = []
    session[:maquina].each do |m|
      @maquinas.push(Maquina.find(m))
    end
  end

  def altera_maquina
    @maquina = (params[:maquina]);
    if (@maquina == 'PLANA')
      render :update do |page|
        page[:maquina_descricao].value = "PLANA"
        page[:maquina_largura_maxima1].value = "240"
        page[:maquina_largura_minima1].value = "0"
        page[:maquina_largura_maxima2].value = "360"
        page[:maquina_largura_minima2].value = "0"
        page[:maquina_tamanho_pinca].value = "8"
        page[:maquina_numerador].value = "0"
        page[:maquina_quebra1000].value = "2"
        page[:maquina_quebra5000].value = "1"
        page[:maquina_quebra_5000].value = "1"
        page[:maquina_reducao_chapado].value = "0"
        page[:maquina_reducao_numerador].value = "0"
        page[:maquina_acerto_numerador].value = "0"
        page[:maquina_quebra_chapado].value = "10"
        page[:maquina_custo].value = "5.00"
        page[:maquina_acerto].value = "15"
      end
    end
    if (@maquina == 'ROTATIVA')
      render :update do |page|
        page[:maquina_descricao].value = "ROTATIVA"
        page[:maquina_largura_maxima1].value = "914"
        page[:maquina_largura_minima1].value = "0"
        page[:maquina_largura_maxima2].value = "578"
        page[:maquina_largura_minima2].value = "0"
        page[:maquina_tamanho_pinca].value = ""
        page[:maquina_numerador].value = ""
        page[:maquina_quebra1000].value = "2"
        page[:maquina_quebra5000].value = "1"
        page[:maquina_quebra_5000].value = "1"
        page[:maquina_reducao_chapado].value = "0"
        page[:maquina_reducao_numerador].value = ""
        page[:maquina_acerto_numerador].value = ""
        page[:maquina_quebra_chapado].value = "10"
        page[:maquina_custo].value = "5.00"
        page[:maquina_acerto].value = "15"
        page[:maquina_ciclo_guilhotina].value = "58"
      end
    end
    if (@maquina == 'INTERCALACAO')
      render :update do |page|
        page[:maquina_descricao].value = "INTERCALAÇÃO"
        page[:maquina_largura_maxima1].value = "680"
        page[:maquina_largura_minima1].value = "0"
        page[:maquina_largura_maxima2].value = "520"
        page[:maquina_largura_minima2].value = "0"
        page[:maquina_tamanho_pinca].value = ""
        page[:maquina_numerador].value = ""
        page[:maquina_quebra1000].value = ""
        page[:maquina_quebra5000].value = ""
        page[:maquina_quebra_5000].value = ""
        page[:maquina_reducao_chapado].value = ""
        page[:maquina_reducao_numerador].value = ""
        page[:maquina_acerto_numerador].value = ""
        page[:maquina_quebra_chapado].value = ""
        page[:maquina_custo].value = "5.00"
        page[:maquina_acerto].value = "1"
      end
    end
    if (@maquina == 'DOBRADEIRA')
      render :update do |page|
        page[:maquina_descricao].value = "DOBRADEIRA"
        page[:maquina_largura_maxima1].value = "680"
        page[:maquina_largura_minima1].value = "0"
        page[:maquina_largura_maxima2].value = "520"
        page[:maquina_largura_minima2].value = "0"
        page[:maquina_tamanho_pinca].value = ""
        page[:maquina_numerador].value = ""
        page[:maquina_quebra1000].value = ""
        page[:maquina_quebra5000].value = ""
        page[:maquina_quebra_5000].value = ""
        page[:maquina_reducao_chapado].value = ""
        page[:maquina_reducao_numerador].value = ""
        page[:maquina_acerto_numerador].value = ""
        page[:maquina_quebra_chapado].value = ""
        page[:maquina_custo].value = "5.00"
        page[:maquina_acerto].value = "1"
      end
    end
    if (@maquina == 'PICOTAR')
      render :update do |page|
        page[:maquina_descricao].value = "PICOTAR"
        page[:maquina_largura_maxima1].value = "680"
        page[:maquina_largura_minima1].value = "0"
        page[:maquina_largura_maxima2].value = "520"
        page[:maquina_largura_minima2].value = "0"
        page[:maquina_tamanho_pinca].value = ""
        page[:maquina_numerador].value = ""
        page[:maquina_quebra1000].value = ""
        page[:maquina_quebra5000].value = ""
        page[:maquina_quebra_5000].value = ""
        page[:maquina_reducao_chapado].value = ""
        page[:maquina_reducao_numerador].value = ""
        page[:maquina_acerto_numerador].value = ""
        page[:maquina_quebra_chapado].value = ""
        page[:maquina_custo].value = "5.00"
        page[:maquina_acerto].value = "1"
      end
    end
    if (@maquina == 'GUILHOTINA')
      render :update do |page|
        page[:maquina_descricao].value = "GUILHOTINA"
        page[:maquina_largura_maxima1].value = "120"
        page[:maquina_largura_minima1].value = ""
        page[:maquina_largura_maxima2].value = ""
        page[:maquina_largura_minima2].value = ""
        page[:maquina_tamanho_pinca].value = ""
        page[:maquina_numerador].value = ""
        page[:maquina_quebra1000].value = ""
        page[:maquina_quebra5000].value = ""
        page[:maquina_quebra_5000].value = ""
        page[:maquina_reducao_chapado].value = ""
        page[:maquina_reducao_numerador].value = ""
        page[:maquina_acerto_numerador].value = ""
        page[:maquina_quebra_chapado].value = ""
        page[:maquina_custo].value = "5.00"
        page[:maquina_acerto].value = "1"
      end
    end

  end

  def edit
    modo = 0
    if params[:id]
      @maquina = Maquina.find(params[:id])
      modo = 1
    else
      @maquina = Maquina.new
      modo = 2
    end
    if request.post?
       @maquina.attributes = params[:maquina]
       if @maquina.save
         if (modo == 2)
           session[:maquina].push(@maquina.id)
         end
         redirect_to :action => "index"
         flash[:notice] = "Maquina salva com sucesso!"
       end
    end
  end

  def delete
    session[:maquina].delete(Maquina.find(params[:id]))
    Maquina.find(params[:id]).destroy
    flash[:notice] = "A Máquina foi excluído com sucesso!"
    redirect_to :action => "list"
  end

end