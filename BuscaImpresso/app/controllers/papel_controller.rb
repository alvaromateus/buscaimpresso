class PapelController < ApplicationController
  layout Proc.new { |controller| controller.session[:usuario] ? "empresa" : "usuario_anonimo" }
  def index
    list
    render :action => "list"
  end

  def list
    @papeis = []
    session[:papel].each do |p|
      @papeis.push(Papel.find(p))
    end
  end

  def altera_papel
    @papel = (params[:papel]);
    if (@papel =='COUCHET')
      render :update do |page|
        page[:papel_descricao].value = "COUCHET LISO"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "120"
        page[:papel_preco_folha].value = "0.10"
        page[:abs_tinta].value = "1"
        page[:papel_tira_retira].checked = true
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='OFF-SET')
      render :update do |page|
        page[:papel_descricao].value = "OFF-SET"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "90"
        page[:papel_preco_folha].value = "0.04"
        page[:abs_tinta].value = "1"
        page[:papel_tira_retira].checked = true
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='VERGE')
      render :update do |page|
        page[:papel_descricao].value = "VERGÊ"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "120"
        page[:papel_preco_folha].value = "0.08"
        page[:abs_tinta].value = "3"
        page[:papel_tira_retira].checked = false
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='SUPER')
      render :update do |page|
        page[:papel_descricao].value = "SUPER BOND"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "60"
        page[:papel_preco_folha].value = "0.03"
        page[:abs_tinta].value = "0"
        page[:papel_tira_retira].checked = false
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = true
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='CARTULINA')
      render :update do |page|
        page[:papel_descricao].value = "CARTULINA"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "150"
        page[:papel_preco_folha].value = "0.15"
        page[:abs_tinta].value = "1"
        page[:papel_tira_retira].checked = true
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='JORNAL')
      render :update do |page|
        page[:papel_descricao].value = "PAPEL JORNAL"
        page[:papel_lado1].value = "630"
        page[:papel_lado2].value = "100"

        page[:papel_gramatura].value = "30"
        page[:papel_preco_folha].value = "500.37"
        page[:abs_tinta].value = "3"
        page[:papel_tira_retira].checked = false
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'BOBINA'
      end
    end
    if (@papel =='RECICLATO')
      render :update do |page|
        page[:papel_descricao].value = "RECICLATO"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "80"
        page[:papel_preco_folha].value = "0.20"
        page[:abs_tinta].value = "1"
        page[:papel_tira_retira].checked = false
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = true
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='FLOR POST')
      render :update do |page|
        page[:papel_descricao].value = "FLOR POST"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "60"
        page[:papel_preco_folha].value = "0.05"
        page[:abs_tinta].value = "1"
        page[:papel_tira_retira].checked = false
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = true
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='CARTÃO')
      render :update do |page|
        page[:papel_descricao].value = "PAPEL CARTÃO"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "180"
        page[:papel_preco_folha].value = "0.15"
        page[:abs_tinta].value = "2"
        page[:papel_tira_retira].checked = true
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='KRAFT')
      render :update do |page|
        page[:papel_descricao].value = "KRAFT"
        page[:papel_lado1].value = "660"
        page[:papel_lado2].value = "960"
        page[:papel_gramatura].value = "120"
        page[:papel_preco_folha].value = "0.10"
        page[:abs_tinta].value = "1"
        page[:papel_tira_retira].checked = true
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'PLANO'
      end
    end
    if (@papel =='FORMULARIO')
      render :update do |page|
        page[:papel_descricao].value = "FORMULARIO CONTÍNUO"
        page[:papel_lado1].value = "216"
        page[:papel_lado2].value = "279"
        page[:papel_gramatura].value = "56"
        page[:papel_preco_folha].value = "52.10"
        page[:abs_tinta].value = "1"
        page[:papel_tira_retira].checked = false
        page[:papel_envelope_pronto].checked = false
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'CONTINUO'
      end
    end
    if (@papel =='ENVELOPE')
      render :update do |page|
        page[:papel_descricao].value = "ENVELOPE LISO"
        page[:papel_lado1].value = "210"
        page[:papel_lado2].value = "120"
        page[:papel_gramatura].value = "60"
        page[:papel_preco_folha].value = "0.05"
        page[:abs_tinta].value = "1"
        page[:papel_tira_retira].checked = true
        page[:papel_envelope_pronto].checked = true
        page[:papel_papel_carbono].checked = false
        page[:tipo].value = 'PLANO'
      end
    end
  end

  def edit
    modo = 0
    if params[:id]
      @papel = Papel.find(params[:id])
      modo = 1
    else
      @papel = Papel.new
      modo = 2
    end
    if request.post?
       @papel.attributes = params[:papel]
       if @papel.save
         redirect_to :action => "index"
         if (modo ==2)
           session[:papel].push(@papel.id) #adicional a mais uma instancia
         end
         flash[:notice] = "Papel salvo com sucesso!"
       end
    end
  end
  def delete
    session[:papel].delete(Papel.find(params[:id]).id)
    Papel.find(params[:id]).destroy
    flash[:notice] = "O papel foi excluído com sucesso!"
    redirect_to :action => "list"
  end

end