
require "mathn"
class HomeController < ApplicationController

  def gera_orcamentos
    @orcamento = params[:form_orcamento]
    orcamentos = TipoOrcamento.find(:all, :conditions => "tipo_id = '#{@orcamento[:tipo_id]}'")

    # loop principal
    @lista = Array.new
    orcamentos.each do |o|
      dimensao = (o.lado1.to_i * o.lado2.to_i)
      impostos = (o.IPI + o.IPI + o.ISV + o.ICMS)

      processos = Processo.find_by_sql("select processos.id,tercerizado,descricao_material,custo,multiplicar,quantidade_paginas,produtividade,quantidade_acerto,cor  from processos,processo_tipo_orcamentos,tipo_orcamentos where processos.id = processo_tipo_orcamentos.processo_id and processo_tipo_orcamentos.tipo_orcamento_id="+o.id.to_s)
      parametros = Parametro.find_by_sql("select refile_padrao,tinta_acerto,preco_tinta_preta,preco_tinta_cor,markup from parametros,empresas,tipo_orcamentos where parametros.id = empresas.parametro_id and empresas.id=tipo_orcamentos.empresa_id and tipo_orcamentos.id=" + o.id.to_s)

      custos = 0.00
      custo_maquina = 0.00
      custo_papel = 0.00
      custo_tinta = 0.00

      paginas_cor = 0
      paginas_pb = 0
      vias = 0

      processos.each do |processo|
        maquina = Processo.find(processo.id).maquina
        papel = Processo.find(processo.id).papel
        
        unless papel && maquina # para processos que não utilizam papel (acabamentos, arte, etc)
           custos += (processo.custo * quantidade_paginas) * @orcamento[:quantidade]
        else          
          # quebra maquina
          if (@orcamento[:quantidade].to_i <= 1000)
            quebra = (maquina.quebra1000)
          end
          if (@orcamento[:quantidade].to_i >= 1000 && @orcamento[:quantidade].to_i < 5000)
            quebra = (maquina.quebra5000)
          end
          if (@orcamento[:quantidade].to_i >= 5000)
            quebra = (maquina.quebra_5000)
          end
  
          #custo maquina
          tempo_minimo = (@orcamento[:quantidade].to_i / processo.produtividade) + (maquina.acerto / 60)
          custo_maquina = maquina.custo * tempo_minimo
         
          #custo papel
          if papel.tipo == 'PLANO'
            quantidade_uma_folha = ((papel.lado1 * papel.lado2) / dimensao)
            quantidade_papel = ((processo.quantidade_paginas + processo.multiplicar) * @orcamento[:quantidade].to_i) / quantidade_uma_folha
            quantidade_papel += (quantidade_papel * (quebra/100.0))
            if quantidade_papel < 1
              quantidade_papel = 1
            end
            custo_papel = quantidade_papel * papel.preco_folha
          end
          if papel.tipo =="BOBINA"
            quantidade_papel = @orcamento[:quantidade].to_i * (papel.gramatura / 1000) * (papel.lado1 / 1000) * (maquina.ciclo_guilhotina / 100)
            quantidade_papel += (quantidade_papel * (quebra/100.0)) # % de quebra
            quantidade_bobinas = quantidade_papel / ((papel.gramatura / 1000)* papel.lado2)
            custo_papel = quantidade_bobinas * papel.preco_folha
          end
          if papel.tipo =="CONTINUO"
            quantidade_papel = @orcamento[:quantidade].to_i * (papel.gramatura / 1000) * (papel.lado1 / 1000) * (0.56)
            quantidade_papel += (quantidade_papel * (quebra/100.0)) # % de quebra
            quantidade_bobinas = quantidade_papel / ((papel.gramatura / 1000)* papel.lado2)
            custo_papel = quantidade_bobinas * papel.preco_folha
          end
  
          # custo tinta
          coeficiente_papel = 0
          case papel.abs_tinta
          when 0
            coeficiente_papel = 1
          when 1
            coeficiente_papel = 1.5
          when 2
            coeficiente_papel = 1.6
          when 3
            coeficiente_papel = 1.8
          when 4
            coeficiente_papel = 2.2
          end
          percentual_area_impressao = 0.20
          quantidade_tinta = ((coeficiente_papel * 0.5 * (dimensao / 100000.0) * @orcamento[:quantidade].to_i * percentual_area_impressao)/353) + (parametros[0].tinta_acerto / 1000.0)
  
          if processo.cor == "PRETO"
            custo_tinta += (quantidade_tinta * parametros[0].preco_tinta_preta)
            paginas_pb = processo.quantidade_paginas.to_i
          end
          if processo.cor == "COLORIDO"
            custo_tinta += (quantidade_tinta * parametros[0].preco_tinta_cor)
            paginas_cor = processo.quantidade_paginas.to_i
          end
          
          if processo.multiplicar > 1
            vias = processo.multiplicar
          end
          custos += custo_papel + custo_maquina + custo_tinta + processo.custo
          custos += custos * parametros[0].markup / 100
        end
      end
      
      # quantidade de cores // isto está foram do loop de processos
      paginas = ""
      if paginas_cor != 0
        paginas = "Páginas coloridas: " + paginas_cor.to_s
      end
      if paginas_pb != 0
        paginas += "<br>Páginas PB: " + paginas_pb.to_s
      end
      if (vias > 0)
        paginas +="<br>Número de vias: " + vias.to_s
      end
      
      #adiciona ao array @lista o orçamento
      empresa = Empresa.find_by_sql("select empresas.id,empresas.razao_social from empresas,tipo_orcamentos where empresas.id = tipo_orcamentos.empresa_id and tipo_orcamentos.id=" + o.id.to_s)
      @lista.push({:custo => custos, :empresa_id => empresa[0][:id], :empresa => empresa[0][:razao_social],:formato => o.lado1.to_s + "x" + o.lado2.to_s + " mm <br> " + paginas, :orcamento => o.id, :quantidade => @orcamento[:quantidade]})
    end
    render :partial => "orcamentos", :layout => define_layout
  end

  def define_layout
    case session[:permissao]
      when 1
        "usuario"
      when 2
        "empresa"
      when 3
        "vendedor"
      else
        "usuario_anonimo"
    end
  end

  def altera_parametros
    render :update do |page|
      page[:form_orcamento_tipo_id].value = "3"
    end
  end

  def index
    @orcamentos = TipoOrcamento.new()
    @tipo_impressos = Tipo.find(:all)
    case session[:permissao]
    when 1
      render :partial => "home", :layout => "usuario"
    when 2
      render :partial => "home", :layout => "empresa"
    when 3
      render :partial => "home", :layout => "vendedor"
    else
      render :partial => "home_anonimo",:layout => "usuario_anonimo"
    end
  end

  def logout
    session.delete
    redirect_to :action => "index"
  end

  def login
    @usuario = Usuario.find_by_login_and_senha(params[:form_login][:login],params[:form_login][:senha])
    if @usuario
      session[:permissao] = 1 # permissão de usuario comum
      session[:usuario] = @usuario.nome
      session[:id] = @usuario.id
      session[:orcamentos] = TipoOrcamento.find(:all)
    else
      @empresa = Empresa.find_by_login_and_senha(params[:form_login][:login],params[:form_login][:senha])
      if @empresa
        session[:permissao] = 2 # permissão de empresa
        session[:usuario] = @empresa.razao_social
        session[:id] = @empresa.id

        session[:maquina] = Maquina.find_by_sql("select maquinas.id from maquinas,processos,processo_tipo_orcamentos,tipo_orcamentos where maquinas.id = processos.maquina_id and processos.id = processo_tipo_orcamentos.processo_id and processo_tipo_orcamentos.tipo_orcamento_id = tipo_orcamentos.id and tipo_orcamentos.empresa_id =" + @empresa.id.to_s)
        session[:processo] = Processo.find_by_sql("select processos.id from processos,processo_tipo_orcamentos,tipo_orcamentos where processos.id = processo_tipo_orcamentos.processo_id and processo_tipo_orcamentos.tipo_orcamento_id = tipo_orcamentos.id and tipo_orcamentos.empresa_id =" + @empresa.id.to_s )
        session[:papel] = Papel.find_by_sql("select papels.id from papels,processos,processo_tipo_orcamentos,tipo_orcamentos where papels.id = processos.papel_id and processos.id = processo_tipo_orcamentos.processo_id and processo_tipo_orcamentos.tipo_orcamento_id = tipo_orcamentos.id and tipo_orcamentos.empresa_id =" + @empresa.id.to_s )
        session[:orcamento] = TipoOrcamento.find_by_sql("select tipo_orcamentos.id from tipo_orcamentos where tipo_orcamentos.empresa_id =" + @empresa.id.to_s)
        session[:parametro] = @empresa.parametro_id
      else
        @vendedor = Vendedor.find_by_login_and_senha(params[:form_login][:login],params[:form_login][:senha])
        if @vendedor
          session[:permissao] = 3
          session[:usuario] = @vendedor.nome
          session[:id] = @vendedor.id
        else
          flash[:login] = "Senha ou nome de usuário inválidos."
          session[:permissao] = 0 # sem permissão
        end
      end
    end
    redirect_to :action => "index"
  end
  
  def ajuda
    render :partial => "ajuda", :layout => define_layout
  end

  def quem_somos
    render :partial => "quem_somos", :layout => define_layout
  end  

  def servicos
    render :partial => "servicos", :layout => define_layout
  end    

  def enviar_pedido
    vendedores = Vendedor.find_by_sql("select vendedors.email from vendedors where empresa_id=" + params[:empresa_id].to_s)
    orcamento = TipoOrcamento.find(params[:orcamento])
    
    # notificação de todos os vendedores via email
#    vendedores.each do |v|
#      NotificacaoVendedor.deliver_notifica_vendedor(orcamento[:descricao], params[:quantidade], v[:email].to_s)
#    end
    # cria orcamento
    os = OrdemServico.new
    os.descricao = orcamento[:descricao]
    os.quantidade = params[:quantidade]
    os.data_entrada = DateTime.now
    os.valor = params[:valor]
    os.usuario_id = session[:id].to_i
    os.tipo_orcamento_id = params[:orcamento].to_i
    os.save

    flash[:notice] = "Sua solicitação foi enviada aos vendedores da empresa solicitada, em breve um deles entrará em contato"
    redirect_to :action => "index"
  end
end
