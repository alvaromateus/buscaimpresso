class ParametroController < ApplicationController
  layout "empresa"
  def index
    list
    render :action => "list"
  end

  def list
    @parametros = Parametro.find :all, :order => "id"
  end

  def edit
    if params[:id]
      @parametro = Parametro.find(params[:id])
    else
      @parametro = Parametro.new
    end
    if request.post?
       @parametro.attributes = params[:parametro]
       if @parametro.save
         redirect_to :action => "index", :controller => "home"
         flash[:notice] = "Parametros salvos com sucesso!"
       end
    end
  end

end