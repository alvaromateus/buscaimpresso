class VendedorController < ApplicationController
  layout Proc.new { |controller| controller.session[:permissao]==2 ? "empresa" : "usuario_anonimo" }

  def index
    list
    render :action => "list"
  end

  def list
    @vendedores = Vendedor.find :all, :order => "nome"
  end

  def edit
    if params[:id]
      @vendedor = Vendedor.find(params[:id])
    else
      @vendedor = Vendedor.new
    end
    if request.post?
        @vendedor.attributes = params[:vendedor]
        @vendedor.empresa_id = session[:id]
        if @vendedor.save
          flash[:notice] = "O vendedor foi salvo com sucesso!"
          redirect_to :action => "index"
        end
    end
  end

  def delete
    Vendedor.find(params[:id]).destroy
    flash[:notice] = "O vendedor foi excluído com sucesso!"
    redirect_to :action => "list"
  end
end
