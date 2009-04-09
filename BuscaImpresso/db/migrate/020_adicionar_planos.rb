class AdicionarPlanos < ActiveRecord::Migration
  def self.up
    Plano.create(:descricao =>'GRÁTIS', :quant_transacoes =>10, :suporte =>0, :gestao_comercial =>0, :valor =>0, :periodo =>'0')
    Plano.create(:descricao =>'BÁSICO', :quant_transacoes =>50, :suporte =>0, :gestao_comercial =>0, :valor =>34.90, :periodo =>'1')
    Plano.create(:descricao =>'MÉDIO', :quant_transacoes =>100, :suporte =>0, :gestao_comercial =>0, :valor =>54.90, :periodo =>'1')
    Plano.create(:descricao =>'EMPRESARIAL', :quant_transacoes =>500, :suporte =>1, :gestao_comercial =>1, :valor =>94.90, :periodo =>'1')
  end

  def self.down
  end
end
